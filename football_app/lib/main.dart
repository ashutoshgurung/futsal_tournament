import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/data/network/network_api_services.dart';
import 'package:football_app/repository/tournament/tournament_api_repository.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';
import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:football_app/view/login/sign_in_screen.dart';
import 'package:football_app/view/signup/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TournamentRepository>(
          create: (_) => TournamentApiRepository(NetworkApiServices()),
          // Real API later (comment out the line above and use this):
          // create: (_) => TournamentApiRepository(NetworkApiServices()),
        ),
        // Add more repositories here later, for example:
        // RepositoryProvider<AuthRepository>(create: (_) => AuthApiRepository(NetworkApiServices())),
      ],
      child: MaterialApp(
        title: 'Football Tournament',
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    );
  }
}
