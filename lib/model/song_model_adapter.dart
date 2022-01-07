import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final typeId = 32;

  @override
  SongModel read(BinaryReader reader) {
    return SongModel(reader.read());
  }

  @override
  void write(BinaryWriter writer, SongModel obj) {
    writer.write(obj.displayNameWOExt);
  }
}
