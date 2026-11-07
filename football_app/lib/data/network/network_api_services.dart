import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  static const _timeout = Duration(seconds: 15);
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

  static const _jsonHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  @override
  Future<dynamic> getApi(String url, {String? token}) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: _headers(token: token))
          .timeout(_timeout);
      return returnResponse(response);
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

  @override
  Future<dynamic> postAPi(String url, var data, {String? token}) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _headers(token: token),
            body: jsonEncode(data),
          )
          .timeout(_timeout);
      return returnResponse(response);
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

    if (code == 200 || code == 201) {
      return jsonDecode(response.body);
    }

    final msg = _errorMessage(response);
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

  /// Reads { "message": "..." } from the backend's error response.
  String? _errorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map && body['message'] is String) {
        return body['message'] as String;
      }
    } catch (_) {}
    return null;
  }
}
