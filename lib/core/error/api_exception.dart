class ApiException<T> implements Exception {
  final String message;
  final T? type;
  ApiException(this.message, {this.type});
}

class NoInternetException extends ApiException {
  NoInternetException()
    : super("No internet connection", type: NoInternetException);
}

class ServerException extends ApiException {
  ServerException() : super("Server failure", type: ServerException);
}

class TimeoutException extends ApiException {
  TimeoutException()
    : super("request time out. Please try again", type: TimeoutException);
}

class FormatException extends ApiException {
  FormatException() : super("Invalid response", type: FormatException);
}

class AuthException extends ApiException {
  AuthException() : super("Authentication failed", type: AuthException);
}

class NotfoundException extends ApiException {
  NotfoundException() : super("Data not found", type: NotfoundException);
}

class UnknownException extends ApiException {
  UnknownException() : super("Something went wrong", type: UnknownException);
}
