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
