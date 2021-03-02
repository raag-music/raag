import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

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

String formatDuration(Duration d) {
  if (d == null) return "--:--";
  int minute = d.inMinutes;
  int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? "0$minute" : "$minute") +
      ":" +
      ((second < 10) ? "0$second" : "$second");
  return format;
}

Widget getAlbumArt(String albumArtWork, double width, BuildContext context) {
  if (albumArtWork == null)
    return Container(
        color: Theme.of(context).dividerColor,
        width: width * 0.15,
        height: width * 0.15,
        child: Icon(Icons.music_note_sharp, color: Theme.of(context).accentColor,));
  else
    return Image(
      image: FileImage(File(albumArtWork)),
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
