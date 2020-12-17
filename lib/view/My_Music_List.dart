import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:raag/DarkThemeProvider.dart';
import 'package:raag/provider/SongWidget.dart';
import 'dart:async';

class MyMusicList extends StatefulWidget {
  @override
  _MyMusicListState createState() => _MyMusicListState();
}

class _MyMusicListState extends State<MyMusicList> {
  final IconData themeButton = Icons.wb_sunny_outlined;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Expanded(
      child: FutureBuilder(
        future:
            FlutterAudioQuery().getSongs(sortType: SongSortType.DISPLAY_NAME),
        builder: (context, snapshot) {
          List<SongInfo> songInfo = snapshot.data;

          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        if (themeChange.darkTheme == true) {
                          themeChange.darkTheme = false;
                        } else {
                          themeChange.darkTheme = true;
                        }
                      },
                      child: Icon(
                        themeButton,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                  title: Hero(
                    tag: "hello",
                    transitionOnUserGestures: true,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        'assets/images/musical.png',
                        width: 40,
                        height: 40,
                      ),
                    )),
                  )),
              body: SongWidget(songList: songInfo),
            );
          } else {
            return Hero(
              tag: "hello",
              transitionOnUserGestures: true,
              child: Container(
                child: Image.asset(
                  'assets/images/musical.png',
                ),

                // child: Container(
                //   padding: EdgeInsets.all(20),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           CircularProgressIndicator(
                //             backgroundColor: Colors.black38,
                //             valueColor: new AlwaysStoppedAnimation<Color>(
                //                 Theme.of(context).accentColor),
                //           ),
                //           SizedBox(
                //             width: 20,
                //           ),
                //           Text(
                //             "Loading",
                //             style: Theme.of(context).textTheme.headline3,
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ),
            );
          }
        },
      ),
    );
  }
}
