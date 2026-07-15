import 'package:hive/hive.dart';
import 'package:marvel_comics/core/constants/hive_constants.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_model.dart';

class ComicHiveService {
  static final Box<ComicModel> _box = Hive.box<ComicModel>(HiveConstants.comic);

  Future<void> addItems(List<ComicModel> models) async {
    for (var i in models) {
      await _box.put(i.id, i);
    }
  }

  List<ComicModel> getAll() {
    return _box.values.toList();
  }

  bool get hasData => _box.isNotEmpty;
}
