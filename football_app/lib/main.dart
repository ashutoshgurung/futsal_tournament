import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/data/network/network_api_services.dart';
import 'package:football_app/data/storage/token_storage.dart';
import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:football_app/repository/auth/auth_repository_impl.dart';
import 'package:football_app/repository/tournament/tournament_api_repository.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';
import 'package:football_app/view/signin/sign_in_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Shared services (created once, reused by every repository)
        RepositoryProvider<BaseApiServices>(
          create: (_) => NetworkApiServices(),
        ),
        RepositoryProvider<TokenStorage>(create: (_) => TokenStorage()),

        // Repositories
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(context.read<AuthRepository>())..add(AppStarted()),
          ),
          // Add other blocs here later
        ],
        child: MaterialApp(
          title: 'Football Tournament',
          debugShowCheckedModeBanner: false,
          home: const SignInScreen(),
        ),
      ),
    );
  }
}
