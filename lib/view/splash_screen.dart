import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/view/onboarding.dart';

import 'home_scaffold.dart';

Preferences _preferencesProvider = new Preferences();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool leaveSplash = false;

  @override
  void initState() {
    super.initState();
    onBoarding();
    awaitPopulateSongs();
  }

  void onBoarding() async{
    if(! await _preferencesProvider.getBool(Preferences.ON_BOARDING_DONE))
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    _preferencesProvider.setBool(Preferences.ON_BOARDING_DONE, true);
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

  static populateSongsIntoDB() async {
    if (await _preferencesProvider.getBool(Preferences.DB_POPULATED) != true) {
      {
        await DBProvider.db.deleteAll();
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
        _preferencesProvider.setBool(Preferences.DB_POPULATED,true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Image.asset(
          'assets/images/musical.png',
          width: 160,
          height: 160,
        ));
  }
}
