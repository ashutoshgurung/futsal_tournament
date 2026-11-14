class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.107:5001',
  );
  static const String login = '$baseUrl/api/auth/login';
  static const String register = '$baseUrl/api/auth/register';
  static const String organizerRegister = '$baseUrl/api/organizers/register';
  static const String publicTournaments = '$baseUrl/api/public/tournaments';
  static const String me = '$baseUrl/api/auth/me';
}
