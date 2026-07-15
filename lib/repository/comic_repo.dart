import 'package:marvel_comics/core/cache/comic_hive_service.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/services/comic_service.dart';
import 'package:marvel_comics/services/favourite_service.dart';

class ComicRepo {
  final ComicService service;
  final ComicHiveService hive;
  final FavouriteService fav;
  ComicRepo(this.service, this.hive, this.fav);

  Future<List<ComicModel>> getComics({int? limit = 20, int? offset = 0}) async {
    try {
      final data = await service.getComics(limit: limit, offset: offset);

      final co = data.map((e) => ComicModel.fromJson(e)).toList();
      await hive.addItems(co);
      return co;
    } on NoInternetException catch (_) {
      if (hive.hasData) {
        return hive.getAll();
      }
      rethrow;
    } on TimeoutException catch (_) {
      if (hive.hasData) {
        return hive.getAll();
      }
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ComicModel>> search(String text) async {
    final data = await service.searchComics(text);

    return data.map((e) => ComicModel.fromJson(e)).toList();
  }

  Future<ComicModel> getDetails(int id) async {
    final data = await service.getComicDetails(id);

    return ComicModel.fromJson(data);
  }

  Future<void> removeComic(int id) async {
    await fav.deleteComic(id);
  }

  Future<void> addItemComic(ComicModel model) async {
    await fav.addfavComic(model);
  }

  bool isContainsComic(int id) {
    return fav.isContainsComic(id);
  }
}
