import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/db_provider.dart';

import 'home_scaffold.dart';

DBStatus _dbStatusProvider = new DBStatus();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool leaveSplash = false;

  @override
  void initState() {
    super.initState();
    awaitPopulateSongs();
  }

  awaitPopulateSongs() async {
    await populateSongsIntoDB();
    setState(() {
      leaveSplash = true;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScaffold()));
  }

  goToHome() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomeScaffold()));

  populateSongsIntoDB() async {
    if (await _dbStatusProvider.isDBPopulated() != true) {
      {
        await DBProvider.db.deleteAll();
        print('inside filler');
        List<SongInfo> songs = await FlutterAudioQuery().getSongs();
        for (var it = 0; it < songs.length; it++) {
          DBProvider.db.insertSong(new Song(
              id: int.parse(songs[it].id),
              title: songs[it].title,
              displayName: songs[it].displayName,
              filePath: songs[it].filePath,
              albumArtwork: songs[it].albumArtwork,
              artist: songs[it].artist,
              album: songs[it].album,
              duration: songs[it].duration,
              composer: songs[it].composer));
        }
        _dbStatusProvider.setDBStatus(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                color: Theme.of(context).backgroundColor,
                child: Image.asset(
                  'assets/images/musical.png',
                  width: 160,
                  height: 160,
                )),
            MaterialButton(
              padding: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: Theme.of(context).accentColor, width: 2)),
              onPressed: () {
                print(leaveSplash);
                if (leaveSplash) goToHome();
                else awaitPopulateSongs();
              },
              child: Text(
                'Let\'s go!',
                style: (Theme.of(context).textTheme.headline3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
