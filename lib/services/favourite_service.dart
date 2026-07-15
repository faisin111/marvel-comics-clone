import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_comics/core/constants/hive_constants.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_model.dart';

class FavouriteService {
  static final Box<CharacterModel> _char = Hive.box<CharacterModel>(
    HiveConstants.charfav,
  );
  static final Box<ComicModel> _comic = Hive.box<ComicModel>(
    HiveConstants.comicfav,
  );

  Future<void> addfavChar(CharacterModel model) async {
    await _char.put(model.id, model);
  }

  List<CharacterModel> getAllChar() {
    return _char.values.toList();
  }

  Future<void> addfavComic(ComicModel model) async {
    await _comic.put(model.id, model);
  }

  List<ComicModel> getAllComic() {
    return _comic.values.toList();
  }

  Future<void> deleteChar(int id) async {
    await _char.delete(id);
  }

  Future<void> deleteComic(int id) async {
    await _comic.delete(id);
  }

  bool isContainsChar(int id) {
    return _char.containsKey(id);
  }

  bool isContainsComic(int id) {
    return _comic.containsKey(id);
  }
}
