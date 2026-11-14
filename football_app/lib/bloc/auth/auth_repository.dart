import 'package:football_app/model/auth_response/auth_response_model.dart';

abstract class AuthRepository {
  Future<({bool loggedIn, AuthResponseModel? session})> restoreSession();

  Future<AuthResponseModel> login(String email, String password);

  Future<AuthResponseModel> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  });

  Future<String?> getGoogleCredential();

  Future<AuthResponseModel> loginWithGoogle(String credential, {String? organizationName});

  Future<void> changePassword(String currentPassword, String newPassword);

  Future<void> logout();
}