import '../models/character_model.dart';
import '../services/character_service.dart';

class CharacterRepository {
  final CharacterService service;

  CharacterRepository(this.service);

  Future<List<CharacterModel>> getCharacters({
    int? limit = 20,
    int? offset = 0,
  }) async {
    final data = await service.getAllcharacters(limit: limit,offset: offset);

    return data.map((e) => CharacterModel.fromJson(e)).toList();
  }

  Future<List<CharacterModel>> search(String text) async {
    final data = await service.searchCharacter(text);

    return data.map((e) => CharacterModel.fromJson(e)).toList();
  }

  Future<CharacterModel> getDetails(int id) async {
    final data = await service.getCharacterDetails(id);

    return CharacterModel.fromJson(data);
  }
}
