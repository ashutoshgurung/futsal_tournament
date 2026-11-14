import 'package:football_app/model/auth_response/auth_response_model.dart';

enum AuthStatus { initial, unauthenticated, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final AuthResponseModel? session;
  final String? message;

  /// true when a new Google account must supply an organization name.
  final bool organizationRequired;

  /// Name from the Google profile (used in the dialog greeting).
  final String? googleName;

  const AuthState({
    this.status = AuthStatus.initial,
    this.session,
    this.message,
    this.organizationRequired = false,
    this.googleName,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthResponseModel? session,
    String? message,
    bool? organizationRequired,
    String? googleName,
  }) =>
      AuthState(
        status: status ?? this.status,
        session: session ?? this.session,
        message: message ?? this.message,
        organizationRequired: organizationRequired ?? this.organizationRequired,
        googleName: googleName ?? this.googleName,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          other.status == status &&
          other.session == session &&
          other.message == message &&
          other.organizationRequired == organizationRequired &&
          other.googleName == googleName;

  @override
  int get hashCode =>
      Object.hash(status, session, message, organizationRequired, googleName);

  @override
  String toString() =>
      'AuthState(status: $status, message: $message, organizationRequired: $organizationRequired)';
}