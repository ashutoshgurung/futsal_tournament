class ApiConfig {
  /// Android emulator -> 10.0.2.2 | iOS simulator -> localhost | real device -> your LAN IP / domain
  /// Override at build time: flutter run --dart-define=API_BASE_URL=https://api.example.com/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api',
  );

  /// MUST be the *Web* OAuth client ID – the same value as GOOGLE_CLIENT_ID on the backend.
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
  );

  static const Duration timeout = Duration(seconds: 20);
}