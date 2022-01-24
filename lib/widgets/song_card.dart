import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/strings.dart';
import '../provider/audio_helper.dart';
import '../provider/player_provider.dart';
import '../provider/theme.dart';

class SongCard extends StatelessWidget {
  const SongCard(
      {Key? key,
      required this.provider,
      required this.song,
      required this.screenWidth,
      required this.songIndex})
      : super(key: key);

  final PlayerProvider provider;
  final SongModel song;
  final double screenWidth;
  final int songIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.all(Radius.circular(24))),
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
                            color: Theme.of(context).colorScheme.secondary,
                            width: 50,
                            height: 50,
                            child: getAlbumArt(
                                song, Theme.of(context).dividerColor))),
                    SizedBox(
                      width: screenWidth * 0.025,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(song.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline3),
                          Text(
                              song.artist
                                      ?.replaceAll(rawUnknown, labelUnknown) ??
                                  labelUnknown,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(parseToMinutesSeconds(song.duration!),
                          style: durationTheme),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
