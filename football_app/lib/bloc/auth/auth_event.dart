sealed class AuthEvent {
  const AuthEvent();

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

  const factory AuthEvent.googleSignInRequested() = GoogleSignInRequested;

  const factory AuthEvent.googleOrganizationSubmitted({
    required String organizationName,
  }) = GoogleOrganizationSubmitted;

  const factory AuthEvent.logoutRequested() = LogoutRequested;

  const factory AuthEvent.sessionExpired() = SessionExpired;
}


final class AppStarted extends AuthEvent {
  const AppStarted();
}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested({required this.email, required this.password});
}

final class RegisterRequested extends AuthEvent {
  final String organizationName;
  final String name;
  final String email;
  final String password;
  const RegisterRequested({
    required this.organizationName,
    required this.name,
    required this.email,
    required this.password,
  });
}

final class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

final class GoogleOrganizationSubmitted extends AuthEvent {
  final String organizationName;
  const GoogleOrganizationSubmitted({required this.organizationName});
}

final class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

final class SessionExpired extends AuthEvent {
  const SessionExpired();
}

