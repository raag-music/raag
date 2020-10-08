import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/view/widget.dart';
import 'package:raag/main.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;
  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    print(songList[0].title);
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = songList[songIndex];
          if (song.displayName.contains(".mp3"))
            return Text(
              song.title,
              style: Theme.of(context).textTheme.headline1,
          );
          return SizedBox(
            height: 0,
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}