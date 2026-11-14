// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:football_app/bloc/auth/auth_bloc.dart';
// import 'package:football_app/bloc/auth/auth_state.dart';
// import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
// import 'package:football_app/view/signin/sign_in_screen.dart';
// import 'package:football_app/view/splash/splash_screen.dart';

// class Startup extends StatefulWidget {
//   const Startup({super.key});

//   @override
//   State<Startup> createState() => _StartupState();
// }

// class _StartupState extends State<Startup> {
//   bool _animationFinished = false;
//   bool _navigating = false;

//   @override
//   void initState() {
//     super.initState();

//     // Show our Flutter animation after the native splash.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FlutterNativeSplash.remove();
//     });
//   }

//   void _onAnimationFinished() {
//     if (!mounted) return;

//     setState(() {
//       _animationFinished = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         final authResolved =
//             state.status != AuthStatus.initial &&
//             state.status != AuthStatus.loading;

//         if (_animationFinished && authResolved && !_navigating) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (!mounted || _navigating) return;

//             _navigating = true;

//             final destination = state.status == AuthStatus.success
//                 ? BottomNavigationScreen()
//                 : const SignInScreen();

//             Navigator.of(
//               context,
//             ).pushReplacement(MaterialPageRoute(builder: (_) => destination));
//           });
//         }

//         return SplashScreen(onFinished: _onAnimationFinished);
//       },
//     );
//   }
// }
