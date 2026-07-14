import 'package:dio/dio.dart';
import 'package:marvel_comics/core/constants/api_constants.dart';

class DioClient {
  final Dio dio;
  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {"Content-Type": "application/json"},
          queryParameters: {"API_KEY": ApiConstants.apiKey},
        ),
      );
}
