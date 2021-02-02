import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/provider/song_widget.dart';
import 'package:raag/widgets/loading_indicator.dart';


class MyMusicList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
        future: DBProvider.db.getAllSongs(),
        builder: (context, snapshot) {
          List<Song> songInfo = snapshot.data;
          if (snapshot.hasData) {
            return SongWidget(songList: songInfo);
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
