import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/auth_response/auth_response_model.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { initial, unauthenticated, loading, success, failure }

enum AuthMethod { email, google }

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    AuthMethod? method,
    AuthResponseModel? session,
    String? message,
  }) = _AuthState;

  bool get isLoading => status == AuthStatus.loading;
  bool get isEmailLoading => isLoading && method == AuthMethod.email;
  bool get isGoogleLoading => isLoading && method == AuthMethod.google;
}