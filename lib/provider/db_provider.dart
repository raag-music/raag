import 'dart:async';
import 'dart:io';
import 'package:raag/model/music_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Song ("
          "id INTEGER PRIMARY KEY,"
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

  Future<List<Song>> getAllSongs() async {
    final db = await database;
    var res = await db.query("Song");
    List<Song> list =
        res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList() : [];
    return list;
  }

  deleteSong(int id) async {
    final db = await database;
    return db.delete("Song", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Song");
  }
}
