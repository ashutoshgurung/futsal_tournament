// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:football_app/bloc/auth/auth_event.dart';
// import 'package:football_app/bloc/auth/auth_state.dart';
// import 'package:football_app/data/exceptions/error_message.dart';
// import 'package:football_app/data/exceptions/organization_required_exception.dart';
// import 'package:football_app/model/auth_response/auth_response_model.dart';
// import 'package:football_app/repository/auth/auth_repository.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository _repo;
//   String? _pendingGoogleCredential;

//   AuthBloc(this._repo) : super(const AuthState(message: 'message')) {
//     on<AppStarted>(_onAppStarted);
//     on<LoginRequested>(_onLogin);
//     on<RegisterRequested>(_onRegister);
//     on<GoogleSignInRequested>(_onGoogle);
//     on<GoogleOrganizationSubmitted>(_onGoogleOrg);
//     on<LogoutRequested>(_onLogout);
//     on<SessionExpired>(_onSessionExpired);
//   }

//   AuthState _ok(AuthResponseModel? s) =>
//       AuthState(status: AuthStatus.success, session: s, message: 'Logged in successfully.');

//   AuthState _fail(Object e) =>
//       AuthState(status: AuthStatus.failure, message: errorMessage(e));

//   static const _loading = AuthState(status: AuthStatus.loading, message: 'Loading...');
//   static const _loggedOut = AuthState(status: AuthStatus.unauthenticated, message: 'Not logged in.');

//   Future<void> _onAppStarted(AppStarted e, Emitter<AuthState> emit) async {
//     try {
//       final r = await _repo.restoreSession();
//       emit(r.loggedIn ? _ok(r.session) : _loggedOut);
//     } catch (_) {

//       emit(_loggedOut);

//     }
//   }

//   Future<void> _onLogin(LoginRequested e, Emitter<AuthState> emit) async {
//     emit(_loading);
//     try {
//       emit(_ok(await _repo.login(e.email, e.password)));
//     } catch (err) {
//       emit(_fail(err));
//     }
//   }

//   Future<void> _onRegister(RegisterRequested e, Emitter<AuthState> emit) async {
//     emit(_loading);
//     try {
//       emit(_ok(await _repo.register(
//         organizationName: e.organizationName,
//         name: e.name,
//         email: e.email,
//         password: e.password,
//       )));
//     } catch (err) {
//       emit(_fail(err));
//     }
//   }

//   Future<void> _onGoogle(GoogleSignInRequested e, Emitter<AuthState> emit) async {
//     emit(_loading);
//     _pendingGoogleCredential = null;
//     try {
//       final credential = await _repo.getGoogleCredential();
//       if (credential == null) {
//         emit(_loggedOut); // user cancelled the picker
//         return;
//       }
//       try {
//         emit(_ok(await _repo.loginWithGoogle(credential)));
//       } on OrganizationRequiredException catch (err) {
//         _pendingGoogleCredential = credential;
//         emit(AuthState(
//           status: AuthStatus.failure,
//           organizationRequired: true,
//           googleName: err.profileName, message: 'Organization required for this Google account. Please enter your organization name to continue.',
//         ));
//       }
//     } catch (err) {
//       emit(_fail(err));
//     }
//   }

//   Future<void> _onGoogleOrg(GoogleOrganizationSubmitted e, Emitter<AuthState> emit) async {
//     final credential = _pendingGoogleCredential;
//     if (credential == null) {
//       emit(_loggedOut);
//       return;
//     }
//     emit(_loading);
//     try {
//       final s = await _repo.loginWithGoogle(credential, organizationName: e.organizationName);
//       _pendingGoogleCredential = null;
//       emit(_ok(s));
//     } catch (err) {
//       emit(_fail(err));
//     }
//   }

//   Future<void> _onLogout(LogoutRequested e, Emitter<AuthState> emit) async {
//     await _repo.logout();
//     emit(_loggedOut);
//   }

//   Future<void> _onSessionExpired(SessionExpired e, Emitter<AuthState> emit) async {
//     await _repo.logout();
//     emit(const AuthState(
//       status: AuthStatus.unauthenticated,
//       message: 'Session expired. Please sign in again.',
//     ));
//   }
// }


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

  AuthState _success(AuthResponseModel? s) =>
      AuthState(status: AuthStatus.success, session: s, message: 'Logged in successfully.');

  AuthState _failure(Object e) => AuthState(status: AuthStatus.failure, message: errorMessage(e));

  // No message, so a plain logged-out state never shows an error snackbar.
  static const _loggedOut = AuthState(status: AuthStatus.unauthenticated);

  AuthState _loading(AuthMethod m) => AuthState(status: AuthStatus.loading, method: m);

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

  Future<void> _onGoogle(GoogleSignInRequested e, Emitter<AuthState> emit) async {
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

  Future<void> _onSessionExpired(SessionExpired e, Emitter<AuthState> emit) async {
    try {
      await _repo.logout();
    } catch (err) {
      debugPrint('logout failed: $err');
    }
    emit(const AuthState(
      status: AuthStatus.unauthenticated,
      message: 'Session expired. Please sign in again.',
    ));
  }
}