import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

AnimationController playFABController;

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

Widget getAlbumArt(SongInfo song) {
  if (song.albumArtwork == null)
    return Container(
        width: 50, height: 50, child: Icon(Icons.music_note_sharp));
  else
    return CircleAvatar(
      backgroundImage: FileImage(File(song.albumArtwork)),
      radius: 50,
      minRadius: 30,
      maxRadius: 70,
    );
}