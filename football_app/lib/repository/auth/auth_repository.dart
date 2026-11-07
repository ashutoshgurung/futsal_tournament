import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';

class AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _tokenStorage;

  AuthRepository(this._api, this._tokenStorage);

  Future<AuthResponseModel> login(String email, String password) async {
    final res = await _api.postAPi(ApiConstants.login, {
      'email': email,
      'password': password,
    });
    return _saveSession(res);
  }

  Future<AuthResponseModel> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.postAPi(ApiConstants.register, {
      'organizationName': organizationName,
      'name': name,
      'email': email,
      'password': password,
    });
    return _saveSession(res);
  }

  Future<void> logout() => _tokenStorage.deleteToken();

  Future<String?> getSavedToken() => _tokenStorage.readToken();

  Future<AuthResponseModel> _saveSession(dynamic json) async {
    final session = AuthResponseModel.fromJson(json);
    if (session.token.isNotEmpty) {
      await _tokenStorage.saveToken(session.token);
    }
    return session;
  }
}