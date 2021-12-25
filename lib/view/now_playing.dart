import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/provider/settings_provider.dart';

class NowPlaying extends StatefulWidget {
  final String url, title, description, image;
  NowPlaying({this.url, this.title, this.description, this.image});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: settingsProvider.darkTheme
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  debugPrint(widget.url);
                  playerProvider.playLocal(widget.url, widget.title,
                      widget.description, widget.image);
                },
                child: Text(
                  'NowPlaying',
                )),
            Text(
              widget.url,
              style: TextStyle(fontSize: 20, color: Colors.green),
            )
          ],
        ));
  }
}
