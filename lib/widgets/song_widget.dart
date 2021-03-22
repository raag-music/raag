import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/provider/theme.dart';

class SongWidget extends StatelessWidget {
  final List<Song> songList;

  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<PlayerProvider>(context);

    Widget getAlbumArt(Song song, BuildContext context) {
      if (song.albumArtwork !=
          null) // Directly access album art when scoped storage approach is not used (less than Android API level 29)
        return Image(
          image: FileImage(File(song.albumArtwork)),
        );

      final defaultIcon = Icon(Icons.music_note_sharp,
          size: 24, color: Theme.of(context).dividerColor);

      return (song.albumArtWorkBytes == null || song.albumArtWorkBytes.isEmpty)
          ? defaultIcon
          : Image.memory(song.albumArtWorkBytes);
    }

    return Column(
      children: [
        Flexible(
          child: ListView.builder(
              itemCount: songList?.length,
              itemBuilder: (context, songIndex) {
                Song song = songList[songIndex];
                if (song.displayName.contains(".mp3"))
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
                            if (provider.audioManagerInstance.isPlaying)
                              provider.audioManagerInstance.toPause();
                            provider.playerState = PlayerState.playing;
                            provider.audioManagerInstance
                                .start("file://${song.filePath}", song.title,
                                desc: song.displayName,
                                auto: true,
                                cover: song.albumArtwork)
                                .then((err) {
                              print(err);
                            });
                            playFABController.forward();
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
                                          color: Theme
                                              .of(context)
                                              .accentColor,
                                          width: 50,
                                          height: 50,
                                          child: getAlbumArt(song, context))),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(song.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline3),
                                        Text(song.artist,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle2),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                      parseToMinutesSeconds(
                                          int.parse(song.duration)),
                                      style: durationTheme),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                return SizedBox(
                  height: 0,
                );
              }),
        ),
      ],
    );
  }
}
