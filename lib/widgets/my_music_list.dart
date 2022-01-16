import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/widgets/loading_indicator.dart';
import 'package:raag/widgets/song_widget.dart';
import 'package:raag/model/strings.dart';

class MyMusicList extends StatefulWidget {
  @override
  State<MyMusicList> createState() => _MyMusicListState();
}

class _MyMusicListState extends State<MyMusicList> {
  @override
  Widget build(BuildContext context) {
    final DBProvider dbProvider = Provider.of<DBProvider>(context);

    return Expanded(
      child: FutureBuilder(
        future: dbProvider.songsList,
        builder: (context, snapshot) {
          List<SongModel> songInfo = [];
          songInfo = snapshot.data;
          if (songInfo?.isNotEmpty ?? false) {
            return SongWidget(songList: songInfo);
          } else if (snapshot.hasData && songInfo.isEmpty) {
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
