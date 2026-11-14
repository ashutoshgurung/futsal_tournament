import 'dart:async';
import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _storage;
  AuthRepositoryImpl(this._api, this._storage);

  Future<void>? _googleInit;
  Future<void> _ensureGoogle() {
    return _googleInit ??= GoogleSignIn.instance
        .initialize(serverClientId: ApiConstants.googleServerClientId)
        .catchError((Object e) {
          _googleInit = null; // allow retry
          throw e;
        });
  }

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
      final res =
          await _api.getApi(ApiConstants.me, token: token)
              as Map<String, dynamic>;
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
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.postAPi(ApiConstants.register, {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    });
    return _persist(res);
  }

  @override
Future<String?> getGoogleCredential() async {
  debugPrint('[GoogleAuth] getGoogleCredential() start');
  try {
    await _ensureGoogle();

    debugPrint('[GoogleAuth] supportsAuthenticate=${GoogleSignIn.instance.supportsAuthenticate()}');
    debugPrint('[GoogleAuth] calling authenticate()...');

    final account = await GoogleSignIn.instance.authenticate();
    debugPrint('[GoogleAuth] account id=${account.id} email=${account.email}');

    final idToken = account.authentication.idToken;
    debugPrint('[GoogleAuth] idToken null? ${idToken == null}, length=${idToken?.length}');

    if (idToken == null) {
      throw BadRequestException('Google did not return an ID token');
    }
    return idToken;
  } on GoogleSignInException catch (e, st) {
    debugPrint('[GoogleAuth] GoogleSignInException');
    debugPrint('  code:        ${e.code}');
    debugPrint('  description: ${e.description}');
    debugPrint('  details:     ${e.details}');
    debugPrintStack(stackTrace: st, maxFrames: 8);

    if (e.code == GoogleSignInExceptionCode.canceled) {
      debugPrint('[GoogleAuth] canceled (picker dismissed, or no eligible account / config issue)');
      return null;
    }
    throw BadRequestException(
      'Google sign-in failed: ${e.description ?? e.code.name}',
    );
  } catch (e, st) {
    debugPrint('[GoogleAuth] Unexpected error: ${e.runtimeType}: $e');
    debugPrintStack(stackTrace: st, maxFrames: 8);
    rethrow;
  }
}

 @override
Future<AuthResponseModel> loginWithGoogle(
  String credential, {
  String? organizationName,
}) async {
  final res = await _api.postAPi(ApiConstants.google, {
    'idToken': credential,
    if (organizationName != null && organizationName.trim().isNotEmpty)
      'organizationName': organizationName.trim(),
  });
  return _persist(res);
}

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
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

  @override
  Future<String?> getSavedToken() => _storage.readToken();

  @override
  Future<bool> hasValidSession() async {
    final token = await _storage.readToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> verifySessionInBackground() async {
    final token = await _storage.readToken();
    if (token == null || token.isEmpty) return;

    try {
      await _api.getApi(ApiConstants.me, token: token);
    } on UnAuthorizedException {
      await _storage.deleteToken();
    } on ForbiddenException {
      await _storage.deleteToken();
    } on NoInternetException {
      // offline: keep the token, try again next time
    } on RequestTimeOutException {
      // same as above
    }
  }
}
