import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

AnimationController playFABController;
double slider = 0.0;

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

Widget getAlbumArt(SongInfo song) {
  if (song.albumArtwork == null)
    return Container(
        width: 60, height: 60, child: Icon(Icons.music_note_sharp));
  else
    return CircleAvatar(
      backgroundImage: FileImage(File(song.albumArtwork)),
      radius: 50,
      // making the following helps with resolving the rendering issues
      // minRadius: 30,
      // maxRadius: 70,
    );
}
