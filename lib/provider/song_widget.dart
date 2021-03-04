import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/view/playback_controls.dart';

import 'audio_helper.dart';

class SongWidget extends StatefulWidget {
  final List<Song> songList;

  SongWidget({@required this.songList});

  @override
  _SongWidgetState createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    playFABController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    playFABController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<PlayerProvider>(context);

    return Stack(
      children: [
        ListView.builder(
            itemCount: widget.songList.length,
            itemBuilder: (context, songIndex) {
              Song song = widget.songList[songIndex];
              if (song.displayName.contains(".mp3"))
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: Theme.of(context).dividerColor, width: 0.7),
                      bottom: BorderSide(
                          color: Theme.of(context).dividerColor, width: 0.7),
                    ),
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: InkWell(
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
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: getAlbumArt(song.albumArtwork, screenWidth, context),
                            ),
                            SizedBox(width: screenWidth * 0.03,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.7,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(
                                      parseToMinutesSeconds(
                                          int.parse(song.duration)),
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              return SizedBox(
                height: 0,
              );
            }),
        PlayBackControls(),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.2,)
      ],
    );
  }
}
