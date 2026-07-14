import 'package:dio/dio.dart';
import 'package:marvel_comics/core/constants/api_constants.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/core/error/error_handler.dart';
import 'package:marvel_comics/core/network/dio_client.dart';

class ComicService {
  final DioClient client = DioClient();

  Future<List<dynamic>> getComics({int? offset = 0, int? limit = 20}) async {
    try {
      Response r= await client.dio.get(
        ApiConstants.issues,
        queryParameters: {"limit": limit, "offset": offset},
      );
     return r.data["results"];
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<dynamic>> searchComics(String search) async {
    try {
      final Response r= await client.dio.get(
        ApiConstants.issues,
        queryParameters: {"filter": "name:$search"},
      );
      return r.data["results"];
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String,dynamic>> getComicDetails(int id) async {
    try {
    final Response r= await client.dio.get(
        "${ApiConstants.issue}/4000-$id",
     
      );
      return r.data["results"];
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
