import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/main.dart';
import 'package:raag/provider/theme.dart';

import 'audio_helper.dart';

class SongWidget extends StatefulWidget {
  final List<SongInfo> songList;

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
    return Stack(
      children: [
        ListView.builder(
            itemCount: widget.songList.length,
            itemBuilder: (context, songIndex) {
              SongInfo song = widget.songList[songIndex];
              if (song.displayName.contains(".mp3"))
                return Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        audioManagerInstance
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
                          getAlbumArt(song),
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(song.title,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.headline3),
                                Text(song.artist,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
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
                );
              return SizedBox(
                height: 0,
              );
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: hex('262626'),
                border: Border.all(color: Colors.white30),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: MediaQuery.of(context).size.height*0.15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                        shape: CircleBorder(),
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          size: 50,
                          progress: playFABController,
                        ),
                        elevation: 0,
                        splashColor: Colors.purple,
                        onPressed: () {
                          audioManagerInstance.isPlaying
                              ? playFABController.reverse()
                              : playFABController.forward();
                          audioManagerInstance.playOrPause();
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    RawMaterialButton(
                      shape: CircleBorder(),
                      onPressed: () {
                        audioManagerInstance.stop();
                        playFABController.reverse();
                      },
                      child: Icon(Icons.stop),
                      elevation: 4,
                      splashColor: Colors.purple,
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget getAlbumArt(SongInfo song) {
    if (song.albumArtwork == null)
      return Container(
          width: 50,
          height: 50,
          child: Icon(Icons.music_note_sharp));
    else
      return CircleAvatar(
        backgroundImage: FileImage(File(song.albumArtwork)),
        radius: 50,
        minRadius: 30,
        maxRadius: 70,
      );
  }
}
