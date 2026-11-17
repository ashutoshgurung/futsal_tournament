import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:football_app/view/organizer/shell/organizer_shell_screen.dart';
import 'package:football_app/view/signin/sign_in_screen.dart';
import 'package:football_app/view/splash/splash_screen.dart';

/// Screen transition duration
const Duration fadeDuration = Duration(milliseconds: 400);

/// Handles the splash animation and decides which screen to show:
/// sign in, player home, or organizer dashboard.
class SplashAuthWrapper extends StatefulWidget {
  const SplashAuthWrapper({super.key});

  @override
  State<SplashAuthWrapper> createState() => _SplashAuthWrapperState();
}

class _SplashAuthWrapperState extends State<SplashAuthWrapper> {
  bool _animationFinished = false;
  bool _authFinished = false;
  bool _nativeSplashRemoved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _removeNativeSplash());
  }

  void _removeNativeSplash() {
    if (_nativeSplashRemoved) return;
    _nativeSplashRemoved = true;
    FlutterNativeSplash.remove();
  }

  void _onAnimationFinished() {
    if (!mounted) return;
    setState(() => _animationFinished = true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!_authFinished &&
            state.status != AuthStatus.initial &&
            state.status != AuthStatus.loading) {
          setState(() => _authFinished = true);
        }
      },
      builder: (context, state) {
        if (!_animationFinished || !_authFinished) {
          return SplashScreen(onFinished: _onAnimationFinished);
        }

        final Widget screen;

        switch (state.status) {
          case AuthStatus.success:
            screen = KeyedSubtree(
              key: ValueKey(state.isOrganizer ? 'organizer' : 'home'),
              child: state.isOrganizer
                  ? const OrganizerShellScreen()
                  : const BottomNavigationScreen(),
            );
            break;

          case AuthStatus.unauthenticated:
          case AuthStatus.failure:
          case AuthStatus.loading:
          case AuthStatus.initial:
          case AuthStatus.registered: // account created, not logged in -> Sign In
            screen = const KeyedSubtree(
              key: ValueKey('signin'),
              child: SignInScreen(),
            );
            break;
        }

        return AnimatedSwitcher(duration: fadeDuration, child: screen);
      },
    );
  }
}