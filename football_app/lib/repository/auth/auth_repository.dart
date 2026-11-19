import 'package:football_app/model/auth_response/auth_response_model.dart';

abstract class AuthRepository {
  /// loggedIn=false  -> no / invalid token (token already deleted).
  /// loggedIn=true, session=null -> offline, cached token kept.
  Future<({bool loggedIn, AuthResponseModel? session})> restoreSession();

  Future<AuthResponseModel> login(String email, String password);

  /// Creates the account. The backend sends a verification email and returns
  /// no token, so the user must verify and then sign in.
  /// Returns the backend's message (may be null).
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  });

  /// Asks the backend to send a new verification email.
  /// Returns the backend's message (same text whether or not the account exists).
  Future<String?> resendVerification(String email);

  /// Opens the Google account picker. Returns the ID token, or null if cancelled.
  Future<String?> getGoogleCredential();

  Future<AuthResponseModel> loginWithGoogle(
    String credential, {
    String? organizationName,
  });

  Future<void> changePassword(String currentPassword, String newPassword);

  Future<void> logout();        // user-initiated: server + local
Future<void> clearSession();  // local only (session expired)

  Future<void> verifySessionInBackground();
  Future<String?> getSavedToken();
  Future<bool> hasValidSession();
}