import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/provider/theme.dart';

class SongWidget extends StatelessWidget {
  final List<SongModel> songList;

  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final provider = Provider.of<PlayerProvider>(context, listen: false);

    provider.updateQueue(songList);

    return Column(
      children: [
        Flexible(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              color: Colors.black,
              axisDirection: AxisDirection.down,
              child: ListView.builder(
                  itemCount: songList?.length,
                  padding: EdgeInsets.only(bottom: screenHeight * 0.2),
                  itemBuilder: (context, songIndex) {
                    SongModel song = songList[songIndex];
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: InkWell(
                            onTap: () {
                              provider.play(songIndex);
                              playPauseController.forward();
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 50,
                                            height: 50,
                                            child: getAlbumArt(
                                                song,
                                                Theme.of(context)
                                                    .dividerColor))),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(song.title ?? 'Untitled',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                          Text(
                                              song.artist?.replaceAll(
                                                      rawUnknown,
                                                      labelUnknown) ??
                                                  labelUnknown,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(parseToMinutesSeconds(song.duration),
                                        style: durationTheme),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
