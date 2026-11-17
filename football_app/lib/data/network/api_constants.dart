import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  static const int _port = 5001;

  /// Override with: --dart-define=API_BASE_URL=http://192.168.1.121:5001
  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    if (kIsWeb) return 'http://localhost:$_port';
    if (Platform.isWindows) return 'http://192.168.1.121:$_port';
    if (Platform.isMacOS) return 'http://localhost:$_port';
    if (Platform.isAndroid) return 'http://10.0.2.2:$_port'; // Android emulator
    return 'http://127.0.0.1:$_port'; // iOS simulator / Linux
  }

  // Endpoints (getters, because baseUrl is no longer a compile-time constant)
  static String get login => '$baseUrl/api/auth/login';
  static String get register => '$baseUrl/api/auth/register';
  static String get organizerRegister => '$baseUrl/api/auth/register';
  static String get publicTournaments => '$baseUrl/api/public/tournaments';
  static String get me => '$baseUrl/api/auth/me';
  static String get google => '$baseUrl/api/auth/google';
  static String get changePassword => '$baseUrl/api/auth/password';
  static String get organization => '$baseUrl/api/organization';
    static String get verifyEmail => '$baseUrl/api/auth/verify-email';
  static String get resendVerification => '$baseUrl/api/auth/resend-verification';

  static const Duration timeout = Duration(seconds: 250);

  /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
  /// Override with: --dart-define=GOOGLE_CLIENT_ID=xxxx.apps.googleusercontent.com
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue:
        '250176959699-nn6e91h4f254qg6f5vphqcd47v0bte3g.apps.googleusercontent.com',
  );
}