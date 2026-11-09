import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = AppStarted;

  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = LoginRequested;

  const factory AuthEvent.registerRequested({
    required String organizationName,
    required String name,
    required String email,
    required String password,
  }) = RegisterRequested;

  const factory AuthEvent.logoutRequested() = LogoutRequested;
  const factory AuthEvent.sessionExpired() = SessionExpired;
}