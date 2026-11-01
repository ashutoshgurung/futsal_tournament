import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 50));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw RequestTimeOutException('');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postAPi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 50));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw RequestTimeOutException('');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        return jsonDecode(response.body);
      case 401:
        throw UnAuthorizedException();
      case 500:
        throw FetchDatastException(
          'Error Communication with server ${response.statusCode}',
        );
      default:
        throw FetchDatastException(
          'Unexpected status code ${response.statusCode}',
        );
    }
  }
}
