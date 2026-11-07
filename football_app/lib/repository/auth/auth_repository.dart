import 'package:football_app/model/auth_response/auth_response_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(String email, String password);

  Future<AuthResponseModel> register({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<String?> getSavedToken();
}
