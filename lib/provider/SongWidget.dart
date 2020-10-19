import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;
  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = songList[songIndex];
          if (song.displayName.contains(".mp3"))
            return Card(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    getAlbumArt(song),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(song.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline3),
                          Text(song.artist,
                              style: Theme.of(context).textTheme.subtitle2),
                          Text(
                              parseToMinutesSeconds(int.parse(song.duration)),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Fluttertoast.showToast(msg: song.filePath);
                      },
                      child:
                      Icon(
                          Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ),
            );
          return SizedBox(
            height: 0,
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }

  Widget getAlbumArt(SongInfo song) {
    if (song.albumArtwork == null)
      return CircleAvatar(
        backgroundImage: AssetImage(
          'assets/images/album.png',
        ),

      );
    else
      return CircleAvatar(
        backgroundImage: FileImage(File(song.albumArtwork)),
      );
  }
}
