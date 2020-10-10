import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/provider/SongWidget.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterAudioQuery().getSongs(sortType: SongSortType.RECENT_YEAR),
      builder: (context, snapshot) {
        List<SongInfo> songInfo = snapshot.data;

        if (snapshot.hasData) {
          for (var i = 0; i < songInfo.length; i++) {
            print(songInfo[i].displayName);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.music_note, size: 50)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songInfo[i].displayName,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline),
                      Text('Artist: ' + songInfo[i].artist),
                    ],
                  ),
                ],
                ),
              ],
            );
          }
          return SongWidget(songList: songInfo);
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.black38,
                valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Loading",
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
        );
      },
    );
  }
}
