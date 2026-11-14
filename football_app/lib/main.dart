import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';

import 'package:football_app/config/routes/navigation_service/navigation_service.dart';

import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/network/network_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';

import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:football_app/repository/auth/auth_repository_impl.dart';
import 'package:football_app/repository/organizer/organizer_repository.dart';
import 'package:football_app/repository/tournament/tournament_api_repository.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';

import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:football_app/view/signin/sign_in_screen.dart';
import 'package:football_app/view/splash/splash_screen.dart';

/// Animation duration
const Duration minSplash = Duration(milliseconds: 3500);

/// Screen transition duration
const Duration fadeDuration = Duration(milliseconds: 400);

late final DateTime _appStart;

void main() {
  _appStart = DateTime.now();

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TokenStorage>(create: (_) => TokenStorage()),

        RepositoryProvider<BaseApiServices>(
          create: (context) =>
              NetworkApiServices(context.read<TokenStorage>())
                ..onUnauthorized = () {
                  final ctx = navigatorKey.currentContext;

                  if (ctx != null) {
                    ctx.read<AuthBloc>().add(const AuthEvent.sessionExpired());
                  }

                  navigatorKey.currentState?.popUntil((route) => route.isFirst);
                },
        ),

        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<BaseApiServices>(),
            context.read<TokenStorage>(),
          ),
        ),

        RepositoryProvider<TournamentRepository>(
          create: (context) =>
              TournamentApiRepository(context.read<BaseApiServices>()),
        ),

        RepositoryProvider<OrganizerRepository>(
          create: (context) =>
              OrganizerRepository(context.read<BaseApiServices>()),
        ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(context.read<AuthRepository>())
                  ..add(const AuthEvent.appStarted()),
          ),
        ],

        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Football Tournament',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.white,
          ),

          themeMode: ThemeMode.light,

          builder: (context, child) {
            return ColoredBox(
              color: Colors.white,
              child: child ?? const SizedBox.shrink(),
            );
          },

          home: const SplashAuthWrapper(),
        ),
      ),
    );
  }
}

/// Handles splash animation and authentication together.
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeNativeSplash();
    });
  }

  void _removeNativeSplash() {
    if (_nativeSplashRemoved) return;

    _nativeSplashRemoved = true;
    FlutterNativeSplash.remove();
  }

  void _onAnimationFinished() {
    if (!mounted) return;

    setState(() {
      _animationFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status != AuthStatus.initial &&
            state.status != AuthStatus.loading) {
          setState(() {
            _authFinished = true;
          });
        }
      },

      builder: (context, state) {
        if (!_animationFinished || !_authFinished) {
          return SplashScreen(onFinished: _onAnimationFinished);
        }

        final Widget screen;

        switch (state.status) {
          case AuthStatus.success:
            screen = const KeyedSubtree(
              key: ValueKey('home'),
              child: BottomNavigationScreen(),
            );
            break;

          case AuthStatus.unauthenticated:
          case AuthStatus.failure:
          case AuthStatus.loading:
          case AuthStatus.initial:
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
