import 'package:dio/dio.dart';
import 'package:marvel_comics/core/error/api_exception.dart';

class ErrorHandler {
  static ApiException handle(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return TimeoutException();
    }
    if (e.type == DioExceptionType.connectionError)
      return NoInternetException();
    switch (e.response?.statusCode) {
      case 400:
        return ApiException("Bad request.");

      case 401:
        return AuthException();

      case 403:
        return ApiException("Access denied.");

      case 404:
        return NotfoundException();

      case 500:
      case 502:
      case 503:
        return ServerException();

      default:
        return UnknownException();
    }
  }
}
