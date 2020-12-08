import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/provider/SongWidget.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
        future: FlutterAudioQuery().getSongs(sortType: SongSortType.DISPLAY_NAME),
        builder: (context, snapshot) {
          List<SongInfo> songInfo = snapshot.data;
          if (snapshot.hasData) {
            return SongWidget(songList: songInfo);
          }
          return Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircularProgressIndicator(),
                      
                  Text(
                    "  Loading",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).accentColor),
                  )
                ]),
              );
