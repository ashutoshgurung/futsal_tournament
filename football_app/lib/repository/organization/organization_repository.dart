import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';

class OrganizationRepository {
  OrganizationRepository(this._api, this._tokenStorage);

  final BaseApiServices _api;
  final TokenStorage _tokenStorage;

  Future<void> register({
    required String organizationName,
    required String contactEmail,
    required String logoUrl,
    required String userName,
    required String email,
    required String password,
  }) async {
    final res = await _api.postAPi(ApiConstants.organizerRegister, {
      'organizationName': organizationName,
      'contactEmail': contactEmail,
      'logoUrl': logoUrl.isEmpty ? null : logoUrl,
      'name': userName, // backend reads `name`
      'email': email.toLowerCase(),
      'password': password,
    });

    final token = (res is Map) ? res['token'] as String? : null;
    if (token == null || token.isEmpty) {
      throw Exception('Registration succeeded but no token was returned');
    }
    await _tokenStorage.saveToken(token);
  }

  /// org + plan limits + usage counts (for the dashboard later).
  Future<Map<String, dynamic>> fetchOverview() async {
    final res = await _api.getApi(ApiConstants.organization);
    return Map<String, dynamic>.from(res as Map);
  }
}