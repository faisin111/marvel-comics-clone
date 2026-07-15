import 'package:hive/hive.dart';

import 'character_model.dart';

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 0;

  @override
  CharacterModel read(BinaryReader reader) {
    return CharacterModel(
      id: reader.readInt(),
      detailedImg: reader.readString(),
      name: reader.readString(),
      realName: reader.readString(),
      deck: reader.readString(),
      image: reader.readString(),
      publisher: reader.readString(),
      origin: reader.readString(),
      issueAppearances: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.detailedImg);
    writer.writeString(obj.name);
    writer.writeString(obj.realName);
    writer.writeString(obj.deck);
    writer.writeString(obj.image);
    writer.writeString(obj.publisher);
    writer.writeString(obj.origin);
    writer.writeInt(obj.issueAppearances);
  }
}