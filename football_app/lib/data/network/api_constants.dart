class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.121:5001',
  );
  static const String login = '$baseUrl/api/auth/login';
  static const String register = '$baseUrl/api/auth/register';
  static const String organizerRegister = '$baseUrl/api/organizers/register';
  static const String publicTournaments = '$baseUrl/api/public/tournaments';
  static const String me =
      '$baseUrl/api/auth/me'; // TODO: use your real protected endpoint

      // ADD these to your existing ApiConstants class (api_constants.dart).
// I assumed it already has `baseUrl`, `login` and `register`; adjust the prefix if yours differs.

  static const String google = '$baseUrl/api/auth/google';
  static const String changePassword = '$baseUrl/api/auth/password';
  static const Duration timeout = Duration(seconds: 20);

  /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
  /// Better: pass with --dart-define=GOOGLE_CLIENT_ID=xxxx.apps.googleusercontent.com
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: '250176959699-ubg7mu51gsltbp7t0nhua27vfsl66isf.apps.googleusercontent.com',
  );

}
