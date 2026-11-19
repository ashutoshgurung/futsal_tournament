  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:go_router/go_router.dart';
  import 'package:football_app/bloc/auth/auth_bloc.dart';
  import 'package:football_app/bloc/auth/auth_state.dart';
  import 'package:football_app/bloc/my_registration/my_registration_bloc.dart';
  import 'package:football_app/config/routes/navigation_service/navigation_service.dart';
  import 'package:football_app/config/routes/route_names.dart';
  import 'package:football_app/repository/my_registration/my_registration_repository.dart';
  import 'package:football_app/view/becomeorganizer/become_organizer_screen.dart';
  import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
  import 'package:football_app/view/forget_password/forget_password_instruction_screen.dart';
  import 'package:football_app/view/forget_password/forget_password_screen.dart';
  import 'package:football_app/view/my_registration/my_registration_screen.dart';
  import 'package:football_app/view/organizer/shell/organizer_shell_screen.dart';
  import 'package:football_app/view/profile/profile_screen.dart';
  import 'package:football_app/view/signin/sign_in_screen.dart';
  import 'package:football_app/view/signup/signup_screen.dart';
  import 'package:football_app/view/splash/splash_screen.dart';

  class _StreamListenable extends ChangeNotifier {
    _StreamListenable(Stream<dynamic> stream) {
      _sub = stream.listen((_) => notifyListeners());
    }
    late final StreamSubscription<dynamic> _sub;

    @override
    void dispose() {
      _sub.cancel();
      super.dispose();
    }
  }

  class AppRouter {
    AppRouter(this.authBloc) {
      _authListenable = _StreamListenable(authBloc.stream);
      router = GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: RouteNames.splash,
        refreshListenable: Listenable.merge([_authListenable, animationDone]),
        redirect: _redirect,
        routes: [
          GoRoute(
            path: RouteNames.splash,
            builder: (_, _) =>
                SplashScreen(onFinished: () => animationDone.value = true),
          ),
          GoRoute(
            path: RouteNames.signIn,
            pageBuilder: (_, s) => _fade(s, const SignInScreen()),
          ),
          GoRoute(
            path: RouteNames.signUp,
            builder: (_, _) => const SignupScreen(),
          ),
          GoRoute(
            path: RouteNames.forgotPassword,
            builder: (_, _) => const ForgetPasswordScreen(),
          ),
          GoRoute(
            path: RouteNames.forgotPasswordSent,
            builder: (_, _) => const ForgetPasswordInstructionScreen(),
          ),
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (_, s) => _fade(s, const BottomNavigationScreen()),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (_, _) => const ProfileScreen(),
          ),
          GoRoute(
            path: RouteNames.myRegistration,
            // Provides its own bloc, because it is no longer inside the tab.
            builder: (_, _) => RepositoryProvider(
              create: (_) => MyRegistrationRepository(),
              child: Builder(
                builder: (ctx) => BlocProvider(
                  create: (_) =>
                      MyRegistrationBloc(ctx.read<MyRegistrationRepository>()),
                  child: const MyRegistrationScreen(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: RouteNames.becomeOrganizer,
            builder: (_, _) => const BecomeOrganizerScreen(),
          ),
          GoRoute(
            path: RouteNames.organizer,
            pageBuilder: (_, s) => _fade(s, const OrganizerShellScreen()),
          ),
        ],
      );
    }

    final AuthBloc authBloc;
    late final GoRouter router;
    late final _StreamListenable _authListenable;
    final ValueNotifier<bool> animationDone = ValueNotifier(false);
    bool _authResolved = false;

    void dispose() {
      _authListenable.dispose();
      animationDone.dispose();
      router.dispose();
    }

    static const _publicRoutes = {
      RouteNames.signIn,
      RouteNames.signUp,
      RouteNames.forgotPassword,
      RouteNames.forgotPasswordSent,
    };

    static const _protectedRoutes = {
      RouteNames.profile,
      RouteNames.myRegistration,
      RouteNames.becomeOrganizer,
      RouteNames.organizer,
    };

    // Sign in / sign up / forgot password pages.
    static const _authRoutes = {
      RouteNames.signIn,
      RouteNames.signUp,
      RouteNames.forgotPassword,
      RouteNames.forgotPasswordSent,
    };


    String? _redirect(BuildContext context, GoRouterState state) {
      final auth = authBloc.state;
      final loc = state.matchedLocation;

      if (!_authResolved &&
          auth.status != AuthStatus.initial &&
          auth.status != AuthStatus.loading) {
        _authResolved = true;
      }
      

      // Stay on splash until animation AND first auth check are done.
      if (!animationDone.value || !_authResolved) {
        return loc == RouteNames.splash ? null : RouteNames.splash;
      }

      // Login in progress: don't move anyone.
      if (auth.status == AuthStatus.loading) return null;

      final loggedIn = auth.status == AuthStatus.success;
final isOrganizer = loggedIn && auth.session?.organization != null;
final landing = isOrganizer ? RouteNames.organizer : RouteNames.home;

// Leave splash for everyone once both checks are done.
if (loc == RouteNames.splash) return landing;

// ---- Guest ----
if (!loggedIn) {
  if (_protectedRoutes.contains(loc)) return RouteNames.signIn;
  return null;
}
// ---- Logged in ---- (rest unchanged)

      // ---- Logged in ----
  if (_authRoutes.contains(loc)) return landing;
  if (isOrganizer && loc == RouteNames.home) return RouteNames.organizer;
  if (!isOrganizer && loc == RouteNames.organizer) return RouteNames.home;
  return null;
   
    }

    static CustomTransitionPage<void> _fade(GoRouterState s, Widget child) =>
        CustomTransitionPage<void>(
          key: s.pageKey,
          child: child,
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
        );
  }
