/// Thrown when /auth/google answers 404 + code ORGANIZATION_REQUIRED
/// (Google account is new, the UI must ask for an organization name).
class OrganizationRequiredException implements Exception {
  final String message;
  final String? profileName;
  OrganizationRequiredException(this.message, {this.profileName});

  @override
  String toString() => message;
}