import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/exceptions/organization_required_exception.dart';
import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';

class NetworkApiServices implements BaseApiServices {
  NetworkApiServices(this._tokenStorage);

  final TokenStorage _tokenStorage;
  static const _timeout = Duration(seconds: 15);
  static const _uploadTimeout = Duration(seconds: 60);

  /// Set once in main.dart. Fires when a request with an auto-attached token gets 401.
  void Function()? onUnauthorized;

  Map<String, String> _headers({String? token}) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  /// Endpoints that must NOT send a token.
  bool _isPublic(String url) =>
      url == ApiConstants.login ||
      url == ApiConstants.register ||
      url == ApiConstants.organizerRegister || // added
      url == ApiConstants.google ||
      url.startsWith(ApiConstants.publicTournaments);

  @override
  Future<dynamic> getApi(String url, {String? token}) =>
      _request('GET', url, token: token);

  @override
  Future<dynamic> postAPi(String url, var data, {String? token}) =>
      _request('POST', url, data: data, token: token);

  @override
  Future<dynamic> putApi(String url, var data, {String? token}) =>
      _request('PUT', url, data: data, token: token);

  @override
  Future<dynamic> deleteApi(String url, {String? token}) =>
      _request('DELETE', url, token: token);

  @override
  Future<dynamic> putMultipart(
    String url, {
    required String field,
    required String filePath,
  }) async {
    final token = await _tokenStorage.readToken();

    return _guard(autoAuth: true, token: token, () async {
      final req = http.MultipartRequest('PUT', Uri.parse(url))
        ..headers['Accept'] = 'application/json'
        // Don't set Content-Type: http adds the multipart boundary itself.
        ..files.add(await http.MultipartFile.fromPath(field, filePath));
      if (token != null && token.isNotEmpty) {
        req.headers['Authorization'] = 'Bearer $token';
      }
      final streamed = await req.send().timeout(_uploadTimeout);
      return returnResponse(await http.Response.fromStream(streamed));
    });
  }

  Future<dynamic> _request(
    String method,
    String url, {
    dynamic data,
    String? token,
  }) async {
    final autoAuth = token == null && !_isPublic(url);
    final effectiveToken =
        token ?? (autoAuth ? await _tokenStorage.readToken() : null);

    return _guard(autoAuth: autoAuth, token: effectiveToken, () async {
      final uri = Uri.parse(url);
      final headers = _headers(token: effectiveToken);
      final body = data == null ? null : jsonEncode(data);

      final Future<http.Response> call = switch (method) {
        'GET' => http.get(uri, headers: headers),
        'POST' => http.post(uri, headers: headers, body: body),
        'PUT' => http.put(uri, headers: headers, body: body),
        'DELETE' => http.delete(uri, headers: headers),
        _ => throw ArgumentError('Unsupported method $method'),
      };

      return returnResponse(await call.timeout(_timeout));
    });
  }

  /// Shared error mapping for JSON and multipart calls.
  Future<dynamic> _guard(
    Future<dynamic> Function() run, {
    required bool autoAuth,
    required String? token,
  }) async {
    try {
      return await run();
    } on UnAuthorizedException {
      if (autoAuth && token != null) {
        await _tokenStorage.deleteToken();
        onUnauthorized?.call();
      }
      rethrow;
    } on SocketException {
      throw NoInternetException('Check your connection and try again');
    } on TimeoutException {
      throw RequestTimeOutException('Server took too long to respond');
    } on http.ClientException {
      throw NoInternetException('Cannot reach the server');
    } on FormatException {
      throw InvalidResponseException();
    }
  }

  dynamic returnResponse(http.Response response) {
    final code = response.statusCode;

    if (code == 200 || code == 201 || code == 204) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }

    final msg = _errorMessage(response);

    final body = _tryDecode(response.body);
    if (body is Map && body['code'] == 'ORGANIZATION_REQUIRED') {
      throw OrganizationRequiredException(
        msg ?? 'Organization name is required',
        profileName:
            (body['profile'] is Map) ? body['profile']['name'] as String? : null,
      );
    }

    switch (code) {
      case 400:
      case 422:
        throw BadRequestException(msg);
      case 401:
        throw UnAuthorizedException(msg);
      case 403:
        throw ForbiddenException(msg);
      case 404:
        throw NotFoundException(msg);
      case 409:
        throw ConflictException(msg);
      case 429:
        throw FetchDatastException('Too many requests, try again shortly');
      default:
        if (code >= 500) {
          throw FetchDatastException('Server error ($code). Try again later');
        }
        throw FetchDatastException('Unexpected status code $code');
    }
  }

  dynamic _tryDecode(String raw) {
    try {
      return jsonDecode(raw);
    } catch (_) {
      return null;
    }
  }

  String? _errorMessage(http.Response response) {
    final body = _tryDecode(response.body);
    if (body is Map && body['message'] is String) return body['message'] as String;
    return null;
  }
}