class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);
  @override
  String toString() {
    return '$_message$_prefix'; // Returns thhe formatted error message
  }
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message])
    : super(message, "No Internet Connection");
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
    : super(message, "You don't have access to this");
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException([String? message])
    : super(message, "Request Time Out");
}

class FetchDatastException extends AppExceptions {
  FetchDatastException([String? message]) : super(message, "");
}
