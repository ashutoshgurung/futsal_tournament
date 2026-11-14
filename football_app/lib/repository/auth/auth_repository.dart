import 'package:football_app/model/auth_response/auth_response_model.dart';

abstract class AuthRepository {
  /// loggedIn=false  -> no / invalid token (token already deleted).
  /// loggedIn=true, session=null -> offline, cached token kept.
  Future<({bool loggedIn, AuthResponseModel? session})> restoreSession();

  Future<AuthResponseModel> login(String email, String password);

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  });

  /// Opens the Google account picker. Returns the ID token, or null if cancelled.
  Future<String?> getGoogleCredential();

  Future<AuthResponseModel> loginWithGoogle(String credential);

  Future<void> changePassword(String currentPassword, String newPassword);

  Future<void> logout();

  Future<void> verifySessionInBackground();
  Future<String?> getSavedToken();
  Future<bool> hasValidSession();
}