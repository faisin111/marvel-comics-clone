import 'package:hive/hive.dart';
import '../models/comic_model.dart';

class ComicModelAdapter extends TypeAdapter<ComicModel> {
  @override
  final int typeId = 1;

  @override
  ComicModel read(BinaryReader reader) {
    return ComicModel(
      id: reader.readInt(),
      name: reader.readString(),
      issueNumber: reader.readString(),
      description: reader.readString(),
      image: reader.readString(),
      volumeName: reader.readString(),
      volumeId: reader.readInt(),
      coverDate: reader.readString(),
      storeDate: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ComicModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.issueNumber);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.writeString(obj.volumeName);
    writer.writeInt(obj.volumeId);
    writer.writeString(obj.coverDate);
    writer.writeString(obj.storeDate);
  }
}