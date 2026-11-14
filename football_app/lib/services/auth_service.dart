import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../core/api_client.dart';
import '../core/api_config.dart';

class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  static const _kToken = 'auth_token';
  static const _kUser = 'auth_user';
  static const _kOrg = 'auth_org';

  final _storage = const FlutterSecureStorage();
  final _api = ApiClient.instance;

  String? token;
  Map<String, dynamic>? user;
  Map<String, dynamic>? organization;

  bool get isLoggedIn => token != null;

  /// Call once before runApp.
  Future<void> init() async {
    await GoogleSignIn.instance
        .initialize(serverClientId: ApiConfig.googleServerClientId);

    token = await _storage.read(key: _kToken);
    final u = await _storage.read(key: _kUser);
    final o = await _storage.read(key: _kOrg);
    if (u != null) user = jsonDecode(u) as Map<String, dynamic>;
    if (o != null) organization = jsonDecode(o) as Map<String, dynamic>;
    _api.setToken(token);

    if (token != null) {
      try {
        final res = await _api.get('/auth/me');
        user = res['user'] as Map<String, dynamic>?;
        organization = res['organization'] as Map<String, dynamic>?;
        await _persist();
      } on ApiException catch (e) {
        if (e.statusCode == 401 || e.statusCode == 403) await logout();
        // other errors (offline etc.): keep the cached session
      }
    }
  }

  // ---------------------------------------------------------------- email/password
  Future<void> login(String email, String password) async {
    final res = await _api.post('/auth/login',
        auth: false,
        body: {'email': email.trim().toLowerCase(), 'password': password});
    await _saveSession(res);
  }

  Future<void> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.post('/auth/register', auth: false, body: {
      'organizationName': organizationName.trim(),
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    });
    await _saveSession(res);
  }

  // ---------------------------------------------------------------- Google
  /// Step 1: opens the Google account picker and returns the ID token (credential).
  /// Returns null if the user cancelled.
  Future<String?> getGoogleCredential() async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) throw ApiException('Google did not return an ID token');
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      throw ApiException('Google sign-in failed: ${e.description ?? e.code.name}');
    }
  }

  /// Step 2: send credential to backend. Throws ApiException(code: 'ORGANIZATION_REQUIRED')
  /// if the account does not exist yet and [organizationName] was not supplied.
  Future<void> loginWithGoogle(String credential, {String? organizationName}) async {
    final res = await _api.post('/auth/google', auth: false, body: {
      'credential': credential,
      if (organizationName != null && organizationName.trim().isNotEmpty)
        'organizationName': organizationName.trim(),
    });
    await _saveSession(res);
  }

  // ---------------------------------------------------------------- misc
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _api.put('/auth/password',
        body: {'currentPassword': currentPassword, 'newPassword': newPassword});
  }

  Future<void> logout() async {
    token = null;
    user = null;
    organization = null;
    _api.setToken(null);
    await _storage.deleteAll();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _saveSession(Map<String, dynamic> res) async {
    token = res['token'] as String;
    user = res['user'] as Map<String, dynamic>?;
    organization = res['organization'] as Map<String, dynamic>?;
    _api.setToken(token);
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    await _storage.write(key: _kToken, value: token);
    await _storage.write(key: _kUser, value: jsonEncode(user));
    await _storage.write(key: _kOrg, value: jsonEncode(organization));
  }
}