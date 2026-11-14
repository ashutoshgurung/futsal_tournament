class AppExceptions implements Exception {
  final String? message;
  final String prefix;
  AppExceptions([this.message, this.prefix = '']);

  /// Text that is safe to show to the user.
  String get userMessage {
    final m = (message ?? '').trim();
    if (m.isNotEmpty) return m;
    if (prefix.isNotEmpty) return prefix;
    return 'Something went wrong. Please try again.';
  }

  @override
  String toString() => userMessage;
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message])
    : super(message, 'No internet connection');
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException([String? message])
    : super(message, 'Request timed out');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, '');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
    : super(message, 'Please log in to continue');
}

class ForbiddenException extends AppExceptions {
  ForbiddenException([String? message])
    : super(message, "You don't have access to this");
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message]) : super(message, 'Not found');
}

class ConflictException extends AppExceptions {
  ConflictException([String? message]) : super(message, '');
}

class FetchDatastException extends AppExceptions {
  FetchDatastException([String? message]) : super(message, '');
}

class InvalidResponseException extends AppExceptions {
  InvalidResponseException([String? message])
    : super(message, 'Invalid response from server');
}
