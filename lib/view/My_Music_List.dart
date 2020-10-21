import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/provider/SongWidget.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterAudioQuery().getSongs(sortType: SongSortType.DISPLAY_NAME),
      builder: (context, snapshot) {
        List<SongInfo> songInfo = snapshot.data;
        if (snapshot.hasData) {
          return Expanded(child: SongWidget(songList: songInfo));
        }
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
            ],
          ),
        );
      },
    );
  }
}
