import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final String? code; // e.g. ORGANIZATION_REQUIRED
  final Map<String, dynamic>? data;
  ApiException(this.message, {this.statusCode, this.code, this.data});

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  String? _token;
  void setToken(String? token) => _token = token;
  bool get hasToken => _token != null;

  /// Called when a request that carried a token comes back 401 (expired / invalid).
  void Function()? onUnauthorized;

  Future<Map<String, dynamic>> get(String path, {bool auth = true}) =>
      _send('GET', path, auth: auth);

  Future<Map<String, dynamic>> post(String path,
          {Map<String, dynamic>? body, bool auth = true}) =>
      _send('POST', path, body: body, auth: auth);

  Future<Map<String, dynamic>> put(String path,
          {Map<String, dynamic>? body, bool auth = true}) =>
      _send('PUT', path, body: body, auth: auth);

  Future<Map<String, dynamic>> delete(String path, {bool auth = true}) =>
      _send('DELETE', path, auth: auth);

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    final req = http.Request(method, uri)
      ..headers['Content-Type'] = 'application/json'
      ..headers['Accept'] = 'application/json';
    if (auth && _token != null) req.headers['Authorization'] = 'Bearer $_token';
    if (body != null) req.body = jsonEncode(body);

    http.Response res;
    try {
      final streamed = await req.send().timeout(ApiConfig.timeout);
      res = await http.Response.fromStream(streamed);
    } on TimeoutException {
      throw ApiException('Request timed out. Please try again.');
    } on SocketException {
      throw ApiException('Cannot reach the server. Check your connection.');
    } on http.ClientException {
      throw ApiException('Cannot reach the server. Check your connection.');
    }

    Map<String, dynamic> json = {};
    if (res.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(res.body);
        if (decoded is Map<String, dynamic>) json = decoded;
      } catch (_) {}
    }

    if (res.statusCode >= 200 && res.statusCode < 300) return json;

    if (res.statusCode == 401 && auth && _token != null) onUnauthorized?.call();

    throw ApiException(
      (json['message'] as String?) ?? 'Something went wrong (${res.statusCode})',
      statusCode: res.statusCode,
      code: json['code'] as String?,
      data: json,
    );
  }
}