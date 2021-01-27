import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/provider/SongWidget.dart';
import 'package:raag/widgets/LoadingIndicator.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
        future: FlutterAudioQuery().getSongs(),
        builder: (context, snapshot) {
          List<SongInfo> songInfo = snapshot.data;
          if (snapshot.hasData) {
            return SongWidget(songList: songInfo);
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
