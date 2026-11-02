// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// import 'package:football_app/data/exceptions/app_exceptions.dart';
// import 'package:football_app/data/network/base_api_services.dart';

// class NetworkApiServices implements BaseApiServices {
//   @override
//   Future<dynamic> getApi(String url) async {
//     dynamic jsonResponse;
//     try {
//       final response = await http
//           .get(Uri.parse(url))
//           .timeout(Duration(seconds: 50));
//       jsonResponse = returnResponse(response);
//       if (response.statusCode == 200) {}
//     } on SocketException {
//       throw NoInternetException('');
//     } on TimeoutException {
//       throw RequestTimeOutException('');
//     }
//     return jsonResponse;
//   }

//   @override
//   Future<dynamic> postAPi(String url, var data) async {
//     dynamic jsonResponse;
//     try {
//       final response = await http
//           .post(Uri.parse(url), body: data)
//           .timeout(Duration(seconds: 50));
//       jsonResponse = returnResponse(response);
//       if (response.statusCode == 200) {}
//     } on SocketException {
//       throw NoInternetException('');
//     } on TimeoutException {
//       throw RequestTimeOutException('');
//     }
//     return jsonResponse;
//   }

//   dynamic returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         return jsonDecode(response.body);
//       case 400:
//         return jsonDecode(response.body);
//       case 401:
//         throw UnAuthorizedException();
//       case 500:
//         throw FetchDatastException(
//           'Error Communication with server ${response.statusCode}',
//         );
//       default:
//         throw FetchDatastException(
//           'Unexpected status code ${response.statusCode}',
//         );
//     }
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  static const _timeout = Duration(seconds: 15);
  static const _jsonHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'})
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
  Future<dynamic> postAPi(String url, var data) async {
    try {
      final response = await http
          .post(Uri.parse(url), headers: _jsonHeaders, body: jsonEncode(data))
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