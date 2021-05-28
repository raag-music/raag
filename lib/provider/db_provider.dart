import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raag/model/music_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "raagDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Song ("
          "id TEXT PRIMARY KEY,"
          "title TEXT,"
          "display_name TEXT,"
          "file_path TEXT,"
          "album_artwork TEXT,"
          "artist TEXT,"
          "album TEXT,"
          "duration TEXT,"
          "composer TEXT,"
          "fav BIT"
          ")");
    });
  }

  insertSongList(List<Song> songs) async {
    for (var iterator = 0; iterator < songs.length; iterator++)
      insertSong(songs[iterator]);
  }

  insertSong(Song newSong) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Song "
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          newSong.id,
          newSong.title,
          newSong.displayName,
          newSong.filePath,
          newSong.albumArtwork,
          newSong.artist,
          newSong.album,
          newSong.duration,
          newSong.composer,
          newSong.fav
        ]);
    return raw;
  }

  getSong(int id) async {
    final db = await database;
    var res = await db.query("Song", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Song.fromMap(res.first) : null;
  }

  Future<int> getCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM Song'));
  }

  Future<List<Song>> getAllSongs() async {
    final db = await database;
    var res = await db.query("Song");
    List<Song> list = [];
    res.forEach((_item) {
      list.add(new Song(
        id: _item['id'],
        title: _item['title'],
        displayName: _item['display_name'],
        filePath: _item['file_path'],
        albumArtwork: _item['album_artwork'],
        artist: _item['artist'],
        album: _item['album'],
        duration: _item['duration'],
        composer: _item['composer'],
        fav: _item['fav'],
      ));
    });
    return list;
  }

  deleteSong(int id) async {
    final db = await database;
    return db.delete("Song", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawQuery("Delete from Song");
  }
}
