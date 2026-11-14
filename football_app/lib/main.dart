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

/// Minimum time the native splash stays visible. Change this value.
const Duration minSplash = Duration(milliseconds: 1800);

/// Fade duration between splash and the first screen.
const Duration fadeDuration = Duration(milliseconds: 400);

/// Android emulator: http://10.0.2.2:3000/api
/// For release builds, pass it in with --dart-define=API_BASE_URL=https://your-api.com/api
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:3000/api',
);

/// Set at the very start of main().
late final DateTime _appStart;

void main() {
  _appStart = DateTime.now();

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep the native splash on screen until we explicitly remove it.
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
                  navigatorKey.currentState?.popUntil((r) => r.isFirst);
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
        // NEW: needed by BecomeOrganizerScreen
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
            // White behind everything, so no black can ever show through.
            return ColoredBox(
              color: Colors.white,
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status == AuthStatus.initial &&
                current.status != AuthStatus.initial,
            listener: (context, state) async {
              // Make sure the splash is visible for at least minSplash.
              final elapsed = DateTime.now().difference(_appStart);
              if (elapsed < minSplash) {
                await Future.delayed(minSplash - elapsed);
              }
              // Then remove it after the next screen is drawn.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FlutterNativeSplash.remove();
              });
            },
            builder: (context, state) {
              final Widget screen;
              switch (state.status) {
                case AuthStatus.success:
                  screen = const KeyedSubtree(
                    key: ValueKey('home'),
                    child: BottomNavigationScreen(),
                  );
                  break;
                case AuthStatus.initial:
                  // Native splash is still covering this, so keep it plain white.
                  screen = const Scaffold(
                    key: ValueKey('initial'),
                    backgroundColor: Colors.white,
                  );
                  break;
                case AuthStatus.unauthenticated:
                case AuthStatus.loading:
                case AuthStatus.failure:
                  // Same key for all three, so the login screen is not
                  // rebuilt or faded while logging in.
                  screen = const KeyedSubtree(
                    key: ValueKey('signin'),
                    child: SignInScreen(),
                  );
                  break;
              }

              return AnimatedSwitcher(duration: fadeDuration, child: screen);
            },
          ),
        ),
      ),
    );
  }
}
