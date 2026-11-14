import 'package:football_app/data/exceptions/organization_required_exception.dart';

/// One place that turns any thrown object into text for the UI.
/// If your exception classes add a prefix (e.g. "Invalid request: ..."),
/// change this function to read their message field instead.
String errorMessage(Object e) {
  if (e is OrganizationRequiredException) return e.message;
  final s = e.toString();
  return s.replaceFirst(RegExp(r'^Exception:\s*'), '');
}