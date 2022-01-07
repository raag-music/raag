import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/provider/audio_query.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/widgets/loading_indicator.dart';
import 'package:raag/widgets/song_widget.dart';
import 'package:raag/model/strings.dart';

class MyMusicList extends StatelessWidget {
  // final OfflineAudioQuery audioQuery = new OfflineAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: DBProvider.getAllSongs(),
        // future: audioQuery.getSongs(),
        builder: (context, snapshot) {
          List<SongModel> songInfo = [];
          songInfo = snapshot.data;
          if (songInfo?.isNotEmpty ?? false) {
            return SongWidget(songList: songInfo);
          } else if (songInfo?.isEmpty ?? true) {
            return Center(
                child: Text(
              noNewMusic,
              style: Theme.of(context).textTheme.subtitle1,
            ));
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
