import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raag/main.dart';
import 'package:raag/view/playback_controls.dart';

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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              size: 20.0,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {
                              Fluttertoast.showToast(msg:'Feature yet to be released');
                              showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(100, 100, 0,
                                      100), //TODO Should not be constant
                                  items: [
                                    PopupMenuItem<String>(
                                        child: const Text('Like'),
                                        value: 'Doge'),
                                    PopupMenuItem<String>(
                                        child: const Text('Add to Playlist'),
                                        value: 'Lion'),
                                    PopupMenuItem<String>(
                                        child: const Text('Song info'),
                                        value: 'Lion'),
                                  ]);
                            },
                          )
                        ],
                      ),
                      title: InkWell(
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
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
        PlayBackControls()
      ],
    );
  }
}
