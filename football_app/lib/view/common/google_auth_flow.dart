import 'package:flutter/material.dart';
import 'package:football_app/core/api_client.dart';
import 'package:football_app/services/auth_service.dart';
import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
import 'auth_widgets.dart';

/// Shared by Sign-in and Sign-up screens. Returns true when the user ended up logged in.
Future<bool> runGoogleAuth(BuildContext context) async {
  final auth = AuthService.instance;
  try {
    final credential = await auth.getGoogleCredential();
    if (credential == null) return false; // cancelled

    try {
      await auth.loginWithGoogle(credential);
    } on ApiException catch (e) {
      if (e.code != 'ORGANIZATION_REQUIRED') rethrow;
      if (!context.mounted) return false;
      final name = (e.data?['profile'] as Map?)?['name'] as String?;
      final org = await askOrganizationName(context, userName: name);
      if (org == null) return false;
      await auth.loginWithGoogle(credential, organizationName: org);
    }

    if (!context.mounted) return true;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => BottomNavigationScreen()),
      (_) => false,
    );
    return true;
  } on ApiException catch (e) {
    if (context.mounted) showError(context, e.message);
    return false;
  }
}