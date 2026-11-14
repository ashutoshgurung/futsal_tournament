
import 'dart:async';


import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
// TODO: adjust this path to wherever your AuthResponseModel lives.
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _storage;
  AuthRepositoryImpl(this._api, this._storage);

  Future<void>? _googleInit;
  Future<void> _ensureGoogle() => _googleInit ??=
      GoogleSignIn.instance.initialize(serverClientId: ApiConstants.googleServerClientId);


  Future<AuthResponseModel> _persist(dynamic res) async {
    final map = res as Map<String, dynamic>;
    // NOTE: assumes TokenStorage has saveToken(String). Rename if yours differs.
    await _storage.saveToken(map['token'] as String);
    return AuthResponseModel.fromJson(map);
  }

  @override
  Future<({bool loggedIn, AuthResponseModel? session})> restoreSession() async {
    final token = await _storage.readToken();
    if (token == null || token.isEmpty) return (loggedIn: false, session: null);

    try {
      // Explicit token => network layer will NOT fire the global 401 redirect.
      final res = await _api.getApi(ApiConstants.me, token: token) as Map<String, dynamic>;
      // /auth/me has no token field, so merge it in for the model.
      final session = AuthResponseModel.fromJson({...res, 'token': token});
      return (loggedIn: true, session: session);
    } on UnAuthorizedException {
      await _storage.deleteToken();
      return (loggedIn: false, session: null);
    } on ForbiddenException {
      await _storage.deleteToken(); // account / organization disabled
      return (loggedIn: false, session: null);
    } on NoInternetException {
      return (loggedIn: true, session: null); // offline: still open the app
    } on RequestTimeOutException {
      return (loggedIn: true, session: null);
    }
  }

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final res = await _api.postAPi(ApiConstants.login, {
      'email': email.trim().toLowerCase(),
      'password': password,
    });
    return _persist(res);
  }

  @override
  Future<AuthResponseModel> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.postAPi(ApiConstants.register, {
      'organizationName': organizationName.trim(),
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    });
    return _persist(res);
  }

  @override
  Future<String?> getGoogleCredential() async {
    await _ensureGoogle();
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) throw BadRequestException('Google did not return an ID token');
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      throw BadRequestException('Google sign-in failed: ${e.description ?? e.code.name}');
    }
  }

  @override
  Future<AuthResponseModel> loginWithGoogle(String credential, {String? organizationName}) async {
    final res = await _api.postAPi(ApiConstants.google, {
      'credential': credential,
      if (organizationName != null && organizationName.trim().isNotEmpty)
        'organizationName': organizationName.trim(),
    });
    return _persist(res);
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _api.putApi(ApiConstants.changePassword, {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  @override
  Future<void> logout() async {
    await _storage.deleteToken();
    try {
      await _ensureGoogle();
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}