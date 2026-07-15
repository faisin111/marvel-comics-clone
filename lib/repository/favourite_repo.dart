import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/services/favourite_service.dart';

class FavouriteRepo {
  final FavouriteService service;
  FavouriteRepo(this.service);

  Future<void> addItemChar(CharacterModel model) async {
    await service.addfavChar(model);
  }

  Future<void> removeChar(int id) async {
    await service.deleteChar(id);
  }
  Future<void> removeComic(int id) async {
    await service.deleteComic(id);
  }
  Future<void> addItemComic(ComicModel model) async {
    await service.addfavComic(model);
  }

  List<CharacterModel> getAllChar() {
    return service.getAllChar();
  }

  List<ComicModel> getAllComic() {
    return service.getAllComic();
  }

  bool isContainsChar(int id) {
    return service.isContainsChar(id);
  }

  bool isContainsComic(int id) {
    return service.isContainsComic(id);
  }
}
