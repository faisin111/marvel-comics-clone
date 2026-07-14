import 'package:dio/dio.dart';
import 'package:marvel_comics/core/constants/api_constants.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/core/error/error_handler.dart';
import 'package:marvel_comics/core/network/dio_client.dart';

class CharacterService {
  final DioClient client = DioClient();

  Future<List<dynamic>> getAllcharacters({
    int? limit = 20,
    int? offset = 0,
  }) async {
    try {
      Response r = await client.dio.get(
        ApiConstants.characters,
        queryParameters: {"offset": offset, "limit": limit},
      );
      return r.data["results"];
    } on DioException catch (e) {
      
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<dynamic>> searchCharacter(String query) async {
    try {
      Response r = await client.dio.get(
        ApiConstants.characters,
        queryParameters: {"filter": "name:$query"},
      );
      return r.data["results"];
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCharacterDetails(int id) async {
    try {
      final response = await client.dio.get("/character/4005-$id/");

      return response.data["results"];
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
