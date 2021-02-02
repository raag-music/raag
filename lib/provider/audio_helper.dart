import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/DBProvider.dart';

AnimationController playFABController;
double slider = 0.0;
DBStatus _dbStatusProvider = new DBStatus();

String parseToMinutesSeconds(int ms) {
  String data;
  Duration duration = Duration(milliseconds: ms);

  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds) - (minutes * 60);

  data = minutes.toString() + ":";
  if (seconds <= 9) data += "0";

  data += seconds.toString();
  return data;
}

String formatDuration(Duration d) {
  if (d == null) return "--:--";
  int minute = d.inMinutes;
  int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? "0$minute" : "$minute") +
      ":" +
      ((second < 10) ? "0$second" : "$second");
  return format;
}

Widget getAlbumArt(Song song) {
  if (song.albumArtwork == null)
    return Container(
        width: 60, height: 60, child: Icon(Icons.music_note_sharp));
  else
    return CircleAvatar(
      backgroundImage: FileImage(File(song.albumArtwork)),
      radius: 50,
      minRadius: 30,
      maxRadius: 70,
    );
}

bool isValidYouTubeURL(String url) {
  url =
      url.replaceAll('://m.y', '://www.y'); //For changing mobile URL to web URL
  print('Web URL: ' + url);
  RegExp regExp = new RegExp(
      r'http(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([(\w)\-\_]*)(&(amp;)?[(\w)\?=]*)?');
  var matches = regExp.allMatches(url);
  if (matches.length == 0)
    return false;
  else
    return true;
}

populateSongsIntoDB() async{
  print(_dbStatusProvider.isDBPopulated());
  if (await _dbStatusProvider.isDBPopulated() != true) {
    DBProvider.db.deleteAll();
    print('inside filler');
    List<SongInfo> songs = await FlutterAudioQuery().getSongs();
    for (var it = 0; it < songs.length; it++) {
      DBProvider.db.insertSong(new Song(
          id: int.parse(songs[it].id),
          title: songs[it].title,
          displayName: songs[it].displayName,
          filePath: songs[it].filePath,
          albumArtwork: songs[it].albumArtwork,
          artist: songs[it].artist,
          album: songs[it].album,
          duration: songs[it].duration,
          composer: songs[it].composer)
      );
    }
    _dbStatusProvider.setDBStatus(true);
  }
}