// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;

// class ApiConstants {
//   static const int _port = 5001;

//   /// Override with: --dart-define=API_BASE_URL=http://192.168.1.121:5001
//   static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');

//   static String get baseUrl {
//     if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
//     if (kIsWeb) return 'http://localhost:$_port';
//     if (Platform.isWindows) return 'http://192.168.1.121:$_port';
//     if (Platform.isMacOS) return 'http://localhost:$_port';
//     if (Platform.isAndroid) return 'http://192.168.1.144:$_port';
//     return 'http://127.0.0.1:$_port'; // iOS simulator / Linux
//   }

//   // Endpoints (getters, because baseUrl is no longer a compile-time constant)
//   static String get login => '$baseUrl/api/auth/login';
//   static String get register => '$baseUrl/api/auth/register';
//   static String get organizerRegister => '$baseUrl/api/auth/register';
//   static String get publicTournaments => '$baseUrl/api/public/tournaments';
//   static String get me => '$baseUrl/api/auth/me';
//   static String get google => '$baseUrl/api/auth/google';
//   static String get changePassword => '$baseUrl/api/auth/password';
//   static String get organization => '$baseUrl/api/organization';
//     static String get verifyEmail => '$baseUrl/api/auth/verify-email';
//   static String get resendVerification => '$baseUrl/api/auth/resend-verification';

//   static const Duration timeout = Duration(seconds: 250);

//   /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
//   /// Override with: --dart-define=GOOGLE_CLIENT_ID=xxxx.apps.googleusercontent.com
//   static const String googleServerClientId = String.fromEnvironment(
//     'GOOGLE_CLIENT_ID',
//     defaultValue:
//         '250176959699-nn6e91h4f254qg6f5vphqcd47v0bte3g.apps.googleusercontent.com',
//   );
// }

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  static const int _port = 5001;

  /// Best option: always pass the URL when running, so nothing is hardcoded.
  ///
  /// Android emulator:  --dart-define=API_BASE_URL=http://10.0.2.2:5001
  /// Real phone (Wi-Fi): --dart-define=API_BASE_URL=http://<PC_LAN_IP>:5001
  /// Real phone (USB):   run `adb reverse tcp:5001 tcp:5001` once, then
  ///                     --dart-define=API_BASE_URL=http://127.0.0.1:5001
  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');

  // IP of the computer that RUNS the backend (check with `ipconfig`).
  // Only used as a fallback when API_BASE_URL is not passed.
  static const String _lanHost = '192.168.1.144';

  static String get baseUrl {
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    if (kIsWeb) return 'http://localhost:$_port';
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'http://localhost:$_port';
    }
    // Android real device. For the emulator use 10.0.2.2 via dart-define.
    if (Platform.isAndroid) return 'http://$_lanHost:$_port';
    return 'http://$_lanHost:$_port'; // iOS real device (simulator: use localhost)
  }

  // Endpoints
  static String get login => '$baseUrl/api/auth/login';
  static String get register => '$baseUrl/api/auth/register';
  static String get organizerRegister => '$baseUrl/api/auth/register';
  static String get publicTournaments => '$baseUrl/api/public/tournaments';
  static String get me => '$baseUrl/api/auth/me';
  static String get google => '$baseUrl/api/auth/google';
  static String get changePassword => '$baseUrl/api/auth/password';
  static String get organization => '$baseUrl/api/organization';
  static String get verifyEmail => '$baseUrl/api/auth/verify-email';
  static String get resendVerification =>
      '$baseUrl/api/auth/resend-verification';

  // 250s hides problems: a bad IP just hangs. Fail fast instead.
  static const Duration timeout = Duration(seconds: 20);

  /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue:
        '250176959699-nn6e91h4f254qg6f5vphqcd47v0bte3g.apps.googleusercontent.com',
  );
}