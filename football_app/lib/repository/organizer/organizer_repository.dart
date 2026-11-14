import 'package:football_app/data/network/api_constants.dart';
import 'package:football_app/data/network/base_api_services.dart';

class OrganizerRepository {
  OrganizerRepository(this._api);

  final BaseApiServices _api;

  Future<void> register({
    required String organizationName,
    required String contactEmail,
    required String logoUrl,
    required String userName,
    required String email,
    required String password,
  }) async {
    await _api.postAPi(ApiConstants.organizerRegister, {
      'organizationName': organizationName,
      'contactEmail': contactEmail,
      'logoUrl': logoUrl.isEmpty ? null : logoUrl,
      'userName': userName,
      'email': email,
      'password': password,
    });
  }
}
