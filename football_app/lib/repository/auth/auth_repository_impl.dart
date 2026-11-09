
import 'dart:async';


import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._api, this._tokenStorage);

 @override
Future<bool> hasValidSession() async {
  final token = await _tokenStorage.readToken();

  if (token == null || token.isEmpty || _isExpired(token)) {
    await _tokenStorage.deleteToken();
    return false;
  }
  return true;
}

@override
Future<void> verifySessionInBackground() async {
  final token = await _tokenStorage.readToken();
  if (token == null) return;

  try {
    await _api
        .getApi(ApiConstants.me, token: token)
        .timeout(const Duration(seconds: 5));
  } on UnAuthorizedException {
    await _tokenStorage.deleteToken();
    rethrow; // the bloc turns this into sessionExpired
  } catch (_) {
    // offline, timeout, 5xx: don't log the user out
  }
}

  bool _isExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (_) {
      return true;
    }
  }

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final json = await _api.postAPi(ApiConstants.login, {
      'email': email,
      'password': password,
    });

    final response = AuthResponseModel.fromJson(json);

    if (response.token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    await _tokenStorage.saveToken(response.token);

    return response;
  }

  @override
  Future<AuthResponseModel> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  }) async {
    final json = await _api.postAPi(ApiConstants.register, {
      'organizationName': organizationName,
      'name': name,
      'email': email,
      'password': password,
    });

    final response = AuthResponseModel.fromJson(json);

    if (response.token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    await _tokenStorage.saveToken(response.token);

    return response;
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.deleteToken();
  }

  @override
  Future<String?> getSavedToken() async {
    return await _tokenStorage.readToken();
  }
}
