import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/widgets/loading_indicator.dart';
import 'package:raag/widgets/song_card.dart';
import 'package:raag/model/strings.dart';

class MyMusicList extends StatefulWidget {
  @override
  State<MyMusicList> createState() => _MyMusicListState();
}

class _MyMusicListState extends State<MyMusicList> {
  @override
  Widget build(BuildContext context) {
    final DBProvider dbProvider = Provider.of<DBProvider>(context);
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: dbProvider.songsList,
      builder: (context, snapshot) {
        List<SongModel>? songList = [];
        songList = snapshot.data as List<SongModel>?;
        if (songList?.isNotEmpty ?? false) {
          playerProvider.updateQueue(songList!);

          return Column(
            children: [
              Flexible(
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    color: Colors.black,
                    axisDirection: AxisDirection.down,
                    child: ListView.builder(
                        itemCount: songList.length,
                        padding: EdgeInsets.only(bottom: screenHeight * 0.2),
                        itemBuilder: (context, songIndex) {
                          SongModel song = songList![songIndex];
                          return SongCard(
                              provider: playerProvider,
                              song: song,
                              screenWidth: screenWidth,
                              songIndex: songIndex);
                        }),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasData && songList!.isEmpty) {
          return Center(
              child: Text(
            noNewMusic,
            style: Theme.of(context).textTheme.subtitle1,
          ));
        }
        return LoadingIndicator();
      },
    );
  }
}
