// import 'package:football_app/data/network/api_constants.dart';
// import 'package:football_app/data/network/base_api_services.dart';
// import 'package:football_app/data/storage/token_storage.dart';
// import 'package:football_app/model/auth_response/auth_response_model.dart';
// import 'package:football_app/repository/auth/auth_repository.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final BaseApiServices _api;
//   final TokenStorage _tokenStorage;

//   AuthRepositoryImpl(this._api, this._tokenStorage);

//   @override
//   Future<AuthResponseModel> login(String email, String password) async {
//     final json = await _api.postAPi(ApiConstants.login, {
//       'email': email,
//       'password': password,
//     });
//     final response = AuthResponseModel.fromJson(json);
//     await _tokenStorage.saveToken(response.token);
//     return response;
//   }

//   @override
//   Future<AuthResponseModel> register({
//     required String organizationName,
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     final json = await _api.postAPi(ApiConstants.register, {
//       'organizationName': organizationName,
//       'name': name,
//       'email': email,
//       'password': password,
//     });
//     final response = AuthResponseModel.fromJson(json);
//     await _tokenStorage.saveToken(response.token);
//     return response;
//   }

//   @override
//   Future<void> logout() => _tokenStorage.deleteToken();

//   @override
//   Future<String?> getSavedToken() => _tokenStorage.readToken();
// }

import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._api, this._tokenStorage);

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
