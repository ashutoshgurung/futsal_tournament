import 'package:football_app/model/auth_response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { initial, loading, success, failure, unauthenticated }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    AuthResponseModel? session,
    String? message,
  }) = _AuthState;
}