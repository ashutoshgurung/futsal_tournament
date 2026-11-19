import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/config/routes/route_names.dart';

/// Returns true if the user is (or just became) logged in.
Future<bool> requireLogin(BuildContext context) async {
  final bloc = context.read<AuthBloc>();
  if (bloc.state.status == AuthStatus.success) return true;

  await context.push(RouteNames.signIn);
  return bloc.state.status == AuthStatus.success;
}