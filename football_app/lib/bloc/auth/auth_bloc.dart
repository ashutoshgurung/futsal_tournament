import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/data/exceptions/error_message.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<GoogleSignInRequested>(_onGoogle);
    on<LogoutRequested>(_onLogout);
    on<SessionExpired>(_onSessionExpired);
  }

  AuthState _loading(AuthMethod m) => state.copyWith(
        status: AuthStatus.loading,
        method: m,
        message: null, // clear any stale error
      );

  AuthState _success(AuthResponseModel? s) => state.copyWith(
        status: AuthStatus.success,
        method: null,
        session: s,
        message: 'Logged in successfully.',
      );

  AuthState _failure(Object e) => state.copyWith(
        status: AuthStatus.failure,
        method: null,
        session: null,
        message: errorMessage(e),
      );

  // Full reset with no message, so a plain logged-out state never shows a snackbar.
  AuthState get _loggedOut =>
      const AuthState(status: AuthStatus.unauthenticated);

  Future<void> _onAppStarted(AppStarted e, Emitter<AuthState> emit) async {
    try {
      final r = await _repo.restoreSession();
      emit(r.loggedIn ? _success(r.session) : _loggedOut);
    } catch (err) {
      debugPrint('restoreSession failed: $err');
      emit(_loggedOut);
    }
  }

  Future<void> _onLogin(LoginRequested e, Emitter<AuthState> emit) async {
    emit(_loading(AuthMethod.email));
    try {
      emit(_success(await _repo.login(e.email.trim(), e.password)));
    } catch (err) {
      emit(_failure(err));
    }
  }

  Future<void> _onRegister(RegisterRequested e, Emitter<AuthState> emit) async {
    emit(_loading(AuthMethod.email));
    try {
      emit(_success(await _repo.register(
        name: e.name.trim(),
        email: e.email.trim(),
        password: e.password,
      )));
    } catch (err) {
      emit(_failure(err));
    }
  }

  Future<void> _onGoogle(
      GoogleSignInRequested e, Emitter<AuthState> emit) async {
    emit(_loading(AuthMethod.google));
    try {
      final credential = await _repo.getGoogleCredential();
      if (credential == null) {
        emit(_loggedOut); // user cancelled the picker
        return;
      }
      emit(_success(await _repo.loginWithGoogle(credential)));
    } catch (err) {
      emit(_failure(err));
    }
  }

  Future<void> _onLogout(LogoutRequested e, Emitter<AuthState> emit) async {
    try {
      await _repo.logout();
    } catch (err) {
      debugPrint('logout failed: $err');
    }
    emit(_loggedOut);
  }

  Future<void> _onSessionExpired(
      SessionExpired e, Emitter<AuthState> emit) async {
    try {
      await _repo.logout();
    } catch (err) {
      debugPrint('logout failed: $err');
    }
    emit(_loggedOut.copyWith(message: 'Session expired. Please sign in again.'));
  }
}