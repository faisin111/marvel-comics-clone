import 'package:marvel_comics/core/cache/character_hive_service.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/services/favourite_service.dart';

import '../models/character_model.dart';
import '../services/character_service.dart';

class CharacterRepository {
  final CharacterService service;
  final CharacterHiveService hive;
  final FavouriteService fav;

  CharacterRepository(this.service, this.hive, this.fav);

  Future<List<CharacterModel>> getCharacters({
    int? limit = 20,
    int? offset = 0,
  }) async {
    try {
      final data = await service.getAllcharacters(limit: limit, offset: offset);

      final ch = data.map((e) => CharacterModel.fromJson(e)).toList();
      await hive.addItems(ch);
      return ch;
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

  Future<List<CharacterModel>> search(String text) async {
    final data = await service.searchCharacter(text);

    return data.map((e) => CharacterModel.fromJson(e)).toList();
  }

  Future<CharacterModel> getDetails(int id) async {
    final data = await service.getCharacterDetails(id);

    return CharacterModel.fromJson(data);
  }

  Future<void> addItemChar(CharacterModel model) async {
    await fav.addfavChar(model);
  }

  Future<void> removeChar(int id) async {
    await fav.deleteChar(id);
  }

  bool isContainsChar(int id) {
    return fav.isContainsChar(id);
  }
}
