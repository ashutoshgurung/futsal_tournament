import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  static const int _port = 5001;

  /// Override with: --dart-define=API_BASE_URL=http://192.168.1.121:5001
  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    if (kIsWeb) return 'http://localhost:$_port';
    if (Platform.isAndroid) return 'http://10.0.2.2:$_port'; // Android emulator -> your Mac
    return 'http://localhost:$_port'; // iOS simulator, macOS
  }

  // Endpoints (getters, because baseUrl is no longer a compile-time constant)
  static String get login => '$baseUrl/api/auth/login';
  static String get register => '$baseUrl/api/auth/register';
  static String get organizerRegister => '$baseUrl/api/organizers/register';
  static String get publicTournaments => '$baseUrl/api/public/tournaments';
  static String get me => '$baseUrl/api/auth/me'; // TODO: use your real protected endpoint
  static String get google => '$baseUrl/api/auth/google';
  static String get changePassword => '$baseUrl/api/auth/password';

  static const Duration timeout = Duration(seconds: 20);

  /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
  /// Override with: --dart-define=GOOGLE_CLIENT_ID=xxxx.apps.googleusercontent.com
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue:
        '250176959699-nn6e91h4f254qg6f5vphqcd47v0bte3g.apps.googleusercontent.com',
  );
}