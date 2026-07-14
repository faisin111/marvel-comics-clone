import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/services/comic_service.dart';

class ComicRepo {
   final ComicService service;

  ComicRepo(this.service);

  Future<List<ComicModel>> getComics({
    int? limit = 20,
    int? offset = 0,
  }) async {
    final data = await service.getComics(limit: limit,offset: offset);

    return data.map((e) => ComicModel.fromJson(e)).toList();
  }

  Future<List<ComicModel>> search(String text) async {
    final data = await service.searchComics(text);

    return data.map((e) => ComicModel.fromJson(e)).toList();
  }

  Future<ComicModel> getDetails(int id) async {
    final data = await service.getComicDetails(id);

    return ComicModel.fromJson(data);
  }
}
