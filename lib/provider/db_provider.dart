import 'dart:async';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raag/model/song_model_adapter.dart';

class DBProvider {
  static Future<void> insertSong(SongModel newSong) async {
    Hive.box('downloads').put(newSong.id, newSong);
  }

  static Future<int> getCount() async => Hive.box('downloads').length;

  static Future<List<SongModel>> getAllSongs() async {
    List<SongModel> list = Hive.box('downloads').values.toList();
    return list;
  }

  static deleteSong(int id) async => await Hive.box('downloads').delete(id);

  static deleteAll() async =>
      Hive.box('downloads').deleteAll(Hive.box('downloads').keys);
}

Future<void> initHive() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('Raag');
  } else {
    await Hive.initFlutter();
  }
  Hive.registerAdapter(SongModelAdapter());
  await openHiveBox('downloads');
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/BlackHole/$boxName.hive');
      lockFile = File('$dirPath/BlackHole/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 800) {
    box.clear();
  }
}
