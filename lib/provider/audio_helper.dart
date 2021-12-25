import 'dart:io';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

AnimationController playPauseController;

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
  int second = (d.inSeconds >= 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? "0$minute" : "$minute") +
      ":" +
      ((second < 10) ? "0$second" : "$second");
  return format;
}

bool isValidYouTubeURL(String url) {
  url =
      url.replaceAll('://m.y', '://www.y'); //For changing mobile URL to web URL
  RegExp youtubeVideoRegExp = new RegExp(
      r'http(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([(\w)\-\_]*)(&(amp;)?[(\w)\?=]*)?');
  var matches = youtubeVideoRegExp.allMatches(url);
  if (matches.length == 0)
    return false;
  else
    return true;
}

Future<File> urlToFile(String imageUrl) async {
  //https://mrgulshanyadav.medium.com/convert-image-url-to-file-format-in-flutter-10421bccfd18
  var random = new Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = new File('$tempPath' + (random.nextInt(100)).toString() + '.png');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

