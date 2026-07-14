class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class NoInternetException extends ApiException {
  NoInternetException() : super("No internet connection");
}

class ServerException extends ApiException {
  ServerException() : super("Server failure");
}

class TimeoutException extends ApiException {
  TimeoutException() : super("request time out. Please try again");
}

class FormatException extends ApiException {
  FormatException() : super("Invalid response");
}

class AuthException extends ApiException {
  AuthException() : super("Authentication failed");
}

class NotfoundException extends ApiException {
  NotfoundException() : super("Data not found");
}

class UnknownException extends ApiException {
  UnknownException() : super("Something went wrong");
}
