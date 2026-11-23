import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/config/routes/navigation_service/navigation_service.dart';
import 'package:football_app/repository/auth/auth_repository.dart';

/// Wrap the app's content with this once (in MaterialApp.router builder).
/// Handles:
///  - footballapp://verify-email?token=...  (verifies, then refreshes the session)
///  - app resume (refreshes the session after "Verify in browser")
class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({super.key, required this.child});
  final Widget child;

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener>
    with WidgetsBindingObserver {
  static const String _scheme = 'footballapp';
  static const String _host = 'verify-email';

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  // Tokens are single-use; never submit the same one twice
  String? _lastToken;
  bool _verifying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initLinks();
  }

  Future<void> _initLinks() async {
    try {
      final initial = await _appLinks.getInitialLink(); // app was closed
      if (initial != null) _handle(initial);
    } catch (e) {
      debugPrint('initial link failed: $e');
    }
    _sub = _appLinks.uriLinkStream.listen(
      _handle, // app already running
      onError: (Object e) => debugPrint('link stream error: $e'),
    );
  }

  Future<void> _handle(Uri uri) async {
    debugPrint('DEEPLINK received: $uri');
    if (uri.scheme != _scheme || uri.host != _host) return;

    final token = uri.queryParameters['token'];
    if (token == null || token.isEmpty) return;
    if (_verifying || token == _lastToken) return;

    _verifying = true;
    _lastToken = token;

    try {
      await context.read<AuthRepository>().verifyEmailToken(token);
      _snack('Email verified');
      // Reload the user; the router redirect handles navigation
      if (mounted) {
        context.read<AuthBloc>().add(const AuthEvent.sessionRefreshRequested());
      }
    } catch (e) {
      _snack(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      _verifying = false;
    }
  }

  // Returning from the browser after "Verify in browser"
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<AuthBloc>().add(const AuthEvent.sessionRefreshRequested());
    }
  }

  void _snack(String message) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}