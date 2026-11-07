import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:football_app/repository/auth/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final token = await _repo.getSavedToken();
      emit(state.copyWith(
        status: (token != null && token.isNotEmpty)
            ? AuthStatus.success
            : AuthStatus.unauthenticated,
      ));
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) {
    return _run(emit, () => _repo.login(event.email, event.password));
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) {
    return _run(
      emit,
      () => _repo.register(
        organizationName: event.organizationName,
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await _repo.logout();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  Future<void> _run(
    Emitter<AuthState> emit,
    Future<AuthResponseModel> Function() call,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final res = await call();
      if (res.token.isEmpty) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          message: 'Something went wrong',
        ));
        return;
      }
      emit(state.copyWith(
        status: AuthStatus.success,
        session: res,
        message: null,
      ));
    } on AppExceptions catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.userMessage));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Something went wrong. Please try again.',
      ));
    }
  }
}