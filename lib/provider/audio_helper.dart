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
      minRadius: 30,
      maxRadius: 70,
    );
}

bool isValidYouTubeURL(String url){
  RegExp regExp = new RegExp(r'http(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([(\w)\-\_]*)(&(amp;)?[(\w)\?=]*)?');
  var matches = regExp.allMatches(url);
  if(matches.length==0) return false;
  else return true;
} 