import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/model/song_model_adapter.dart';
import 'audio_query.dart';

class DBProvider extends ChangeNotifier {
  Future<List<SongModel>> songsList = getAllSongs();

  Future<void> insertSong(SongModel newSong) async {
    Hive.box('downloads').put(newSong.id, newSong);
  }

  // Future<int> getCount() async => Hive.box('downloads').length;

  static Future<List<SongModel>> getAllSongs() async {
    // songsList = Hive.box('downloads').values.toList();
    final OfflineAudioQuery audioQuery = new OfflineAudioQuery();
    Future<List<SongModel>> _songsList = (audioQuery.getSongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.DESC_OR_GREATER,
    ));
    return _songsList;
  }

  deleteSong(int id) async => await Hive.box('downloads').delete(id);

  deleteAll() async =>
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
  // final box = await Hive.openBox(boxName).onError((dynamic error, stackTrace) async {
  //   final Directory dir = await getApplicationDocumentsDirectory();
  //   final String dirPath = dir.path;
  //   File dbFile = File('$dirPath/$boxName.hive');
  //   File lockFile = File('$dirPath/$boxName.lock');
  //   if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //     dbFile = File('$dirPath/BlackHole/$boxName.hive');
  //     lockFile = File('$dirPath/BlackHole/$boxName.lock');
  //   }
  //   await dbFile.delete();
  //   await lockFile.delete();
  //   await Hive.openBox(boxName);
  //   throw 'Failed to open $boxName Box\nError: $error';
  // } as FutureOr<Box<dynamic>> Function(_, StackTrace));
  // // clear box if it grows large
  // if (limit && box.length > 800) {
  //   box.clear();
  // }
}
