import 'package:flutter/foundation.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
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

    if (kDebugMode) {
      // Keys matra print garne, token / personal data hoina.
      debugPrint(
        '[OrganizerRegister] response: '
        '${res is Map ? res.keys.toList() : res.runtimeType}',
      );
    }

    final token = _extractToken(res);
    if (token == null) {
      // Account bani sakyo, tara login token aayena.
      throw BadRequestException(
        'Account created, but you are not signed in yet. '
        'Please verify your email, then sign in.',
      );
    }
    await _tokenStorage.saveToken(token);
  }

  String? _extractToken(dynamic res) {
    if (res is! Map) return null;
    final direct = res['token'];
    if (direct is String && direct.isNotEmpty) return direct;
    final data = res['data'];
    if (data is Map && data['token'] is String) {
      final t = data['token'] as String;
      if (t.isNotEmpty) return t;
    }
    return null;
  }

  /// org + plan limits + usage counts (for the dashboard later).
  Future<Map<String, dynamic>> fetchOverview() async {
    final res = await _api.getApi(ApiConstants.organization);
    return Map<String, dynamic>.from(res as Map);
  }
}