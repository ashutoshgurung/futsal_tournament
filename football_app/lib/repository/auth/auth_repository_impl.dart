import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices _api;
  final TokenStorage _storage;
  AuthRepositoryImpl(this._api, this._storage);

  void _log(String message) {
    if (kDebugMode) debugPrint('[GoogleAuth] $message');
  }

  Future<void>? _googleInit;
  Future<void> _ensureGoogle() {
    return _googleInit ??= GoogleSignIn.instance
        .initialize(serverClientId: ApiConstants.googleServerClientId)
        .catchError((Object e) {
          _googleInit = null;
          throw e;
        });
  }

  Future<AuthResponseModel> _persist(dynamic res) async {
    final map = res as Map<String, dynamic>;
    await _storage.saveToken(map['token'] as String);
    return AuthResponseModel.fromJson(map);
  }

  String? _messageOf(dynamic res) =>
      res is Map ? res['message'] as String? : null;

  @override
  Future<({bool loggedIn, AuthResponseModel? session})> restoreSession() async {
    final token = await _storage.readToken();
    if (token == null || token.isEmpty) return (loggedIn: false, session: null);

    try {
      final res =
          await _api.getApi(ApiConstants.me, token: token)
              as Map<String, dynamic>;
      final session = AuthResponseModel.fromJson({...res, 'token': token});
      return (loggedIn: true, session: session);
    } on UnAuthorizedException {
      await _storage.deleteToken();
      return (loggedIn: false, session: null);
    } on ForbiddenException {
      await _storage.deleteToken();
      return (loggedIn: false, session: null);
    } on NoInternetException {
      return (loggedIn: true, session: null);
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
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.postAPi(ApiConstants.register, {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    });
    // No _persist: regular users verify their email first.
    return _messageOf(res);
  }

  @override
  Future<String?> resendVerification(String email) async {
    final res = await _api.postAPi(ApiConstants.resendVerification, {
      'email': email.trim().toLowerCase(),
    });
    return _messageOf(res);
  }

  /// Exchanges the emailed verification token for a login session and
  /// stores the JWT. The bloc's session refresh then loads the user.
  @override
  Future<void> verifyEmailToken(String token) async {
    final res = await http
        .post(
          Uri.parse(ApiConstants.verifyEmail),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'token': token}),
        )
        .timeout(ApiConstants.timeout);

    Map<String, dynamic> body;
    try {
      body = jsonDecode(res.body) as Map<String, dynamic>;
    } catch (_) {
      throw Exception('Verification failed');
    }

    if (res.statusCode != 200 || body['success'] != true) {
      throw Exception(body['message'] ?? 'Verification failed');
    }

    final jwt = body['token'] as String?;
    if (jwt == null || jwt.isEmpty) {
      throw Exception('Verification failed');
    }
    await _storage.saveToken(jwt); // <-- this is what keeps the user logged in
  }

  /// Used by the footballapp://login?token=... link (browser fallback).
  @override
  Future<void> saveToken(String jwt) => _storage.saveToken(jwt);

  @override
  Future<String?> getGoogleCredential() async {
    _log('start');
    try {
      await _ensureGoogle();
      _log(
        'supportsAuthenticate=${GoogleSignIn.instance.supportsAuthenticate()}',
      );

      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      _log('idToken received: ${idToken != null}');

      if (idToken == null) {
        throw BadRequestException('Google did not return an ID token');
      }
      return idToken;
    } on GoogleSignInException catch (e, st) {
      _log('GoogleSignInException code=${e.code} description=${e.description}');
      if (kDebugMode) debugPrintStack(stackTrace: st, maxFrames: 8);

      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw BadRequestException(
        'Google sign-in failed: ${e.description ?? e.code.name}',
      );
    } catch (e, st) {
      _log('Unexpected error: ${e.runtimeType}');
      if (kDebugMode) debugPrintStack(stackTrace: st, maxFrames: 8);
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
    final token = await _storage.readToken(); // read BEFORE deleting
    if (token != null && token.isNotEmpty) {
      try {
        await _api
            .postAPi(ApiConstants.logout, {}, token: token)
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        _log('server logout failed: ${e.runtimeType}');
      }
    }
    await clearSession();
  }

  @override
  Future<void> clearSession() async {
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
      // offline: keep the token
    } on RequestTimeOutException {
      // same
    }
  }
}
