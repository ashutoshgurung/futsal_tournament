class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.144:5001',
  );

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

  static final String logout = '$baseUrl/api/auth/logout';

  // 250s hides problems: a bad IP just hangs. Fail fast instead.
  static const Duration timeout = Duration(seconds: 20);

  /// The *Web* OAuth client ID (same value as GOOGLE_CLIENT_ID in the backend .env).
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue:
        '250176959699-nc705ti9phce81bhoao0dcn4g3m8uahp.apps.googleusercontent.com',
  );
}
