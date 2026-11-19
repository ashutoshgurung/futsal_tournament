import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/config/routes/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(context.read<AuthBloc>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.router,
      title: 'Football Tournament',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,
      ),
      themeMode: ThemeMode.light,
      builder: (context, child) => ColoredBox(
        color: Colors.white,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
