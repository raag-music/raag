import 'package:flutter/material.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/widgets/loading_indicator.dart';
import 'package:raag/widgets/song_widget.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
        future: DBProvider.db.getAllSongs(),
        builder: (context, snapshot) {
          List<Song> songInfo = snapshot.data;
          if (songInfo?.isNotEmpty ?? true) {
            return SongWidget(songList: songInfo);
          } else if (songInfo?.isEmpty ?? true) {
            return Text('No music files found :(');
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
