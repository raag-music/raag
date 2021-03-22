import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/model/music_model.dart';

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

Widget getAlbumArt(Song song, BuildContext context) {
  if (song.albumArtwork != null)
    return Image(
      image: FileImage(File(song
          .albumArtwork)), // Directly access album art when scoped storage approach is not used (less than Android API level 29)
    );

  final defaultIcon = Icon(Icons.music_note_sharp,
      size: 24, color: Theme.of(context).dividerColor);
  FlutterAudioQuery audioQueryInstance = FlutterAudioQuery();
  try {
    return FutureBuilder(
        future:
            audioQueryInstance.getArtwork(type: ResourceType.SONG, id: song.id),
        builder: (_, snapshot) {
          Uint8List imageBytes = snapshot.data;
          if (snapshot.data == null || imageBytes.isEmpty) {
            return defaultIcon;
          } else {
            print(song.displayName);
            return Image.memory(snapshot.data);
          }
        });
  } catch (e) {
    return defaultIcon;
  }
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
