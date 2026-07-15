import 'package:hive/hive.dart';
import 'package:marvel_comics/core/constants/hive_constants.dart';
import 'package:marvel_comics/models/character_model.dart';

class CharacterHiveService {
  static final Box<CharacterModel> _box = Hive.box<CharacterModel>(
    HiveConstants.character,
  );

  Future<void> addItems(List<CharacterModel> models) async {
    await _box.clear();
    for (var i in models) {
      await _box.put(i.id, i);
    }
  }

  List<CharacterModel> getAll() {
    return _box.values.toList();
  }

  bool get hasData => _box.isNotEmpty;
}
