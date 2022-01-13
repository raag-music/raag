import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raag/provider/audio_query.dart';

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

Widget getAlbumArt(SongModel song, Color iconColor) {
  final OfflineAudioQuery audioQuery = new OfflineAudioQuery();
  final defaultIcon = Icon(Icons.music_note_sharp, size: 24, color: iconColor);
  // if (song?.albumArtwork !=
  //     null) // Directly access album art when scoped storage approach is not used (less than Android API level 29)
  //   return Image(
  //     image: FileImage(File(song.albumArtwork)),
  //   );
  return FutureBuilder(
    future: audioQuery.getAlbumArt(song?.id),
    builder: (context, snapshot) {
      Uint8List _imageBytes = snapshot.data;
      if (_imageBytes == null || _imageBytes.isEmpty)
        return defaultIcon;
      else
        return Image.memory(_imageBytes, fit: BoxFit.cover);
    },
  );
}

Widget getMediaAlbumArt(MediaItem song, Color iconColor) {
  final OfflineAudioQuery audioQuery = new OfflineAudioQuery();
  final defaultIcon = Icon(Icons.music_note_sharp, size: 24, color: iconColor);
  // if (song?.albumArtwork !=
  //     null) // Directly access album art when scoped storage approach is not used (less than Android API level 29)
  //   return Image(
  //     image: FileImage(File(song.albumArtwork)),
  //   );
  return FutureBuilder(
    future: audioQuery.getAlbumArt(int.parse(song?.id)),
    builder: (context, snapshot) {
      Uint8List _imageBytes = snapshot.data;
      if (_imageBytes == null || _imageBytes.isEmpty)
        return defaultIcon;
      else
        return Image.memory(_imageBytes, fit: BoxFit.cover);
    },
  );
}

Future<Uri> getArtUri(SongModel song) async {
  final OfflineAudioQuery audioQuery = new OfflineAudioQuery();
  return Uri.file(
      File.fromRawPath(await audioQuery.getAlbumArt(song?.id)).path);
}

MediaItem downMapToMediaItem(Map song) {
  return MediaItem(
    id: song['id'].toString(),
    album: song['album'].toString(),
    artist: song['artist'].toString(),
    duration: Duration(
      seconds: int.parse(
        (song['duration'] == null || song['duration'] == 'null')
            ? '180'
            : song['duration'].toString(),
      ),
    ),
    title: song['title'].toString(),
    artUri: Uri.file(song['image'].toString()),
    genre: song['genre'].toString(),
    extras: {
      'url': song['path'].toString(),
      'year': song['year'],
      'language': song['genre'],
      'release_date': song['release_date'],
      'album_id': song['album_id'],
      'subtitle': song['subtitle'],
      'quality': song['quality'],
    },
  );
}
