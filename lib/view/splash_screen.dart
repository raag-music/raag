import 'package:flutter/material.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/provider/audio_query.dart';
import 'package:raag/view/onboarding.dart';

import 'home_scaffold.dart';

Preferences _preferencesProvider = new Preferences();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static populateSongsIntoDB() async {
    // OfflineAudioQuery offlineAudioQuery = new OfflineAudioQuery();
    await OfflineAudioQuery.requestPermission();
    // if (await _preferencesProvider.getBool(Preferences.DB_POPULATED) != true) {
    //   {
    //     List _songs = (await offlineAudioQuery.getSongs(
    //       sortType: SongSortType.DATE_ADDED,
    //       orderType: OrderType.DESC_OR_GREATER,
    //     ))
    //         .where((i) =>
    //                 (i.duration ?? 60000) >
    //                 1000 * 10 // 10 seconds is the minimum duration
    //             )
    //         .toList();
    //     _songs.forEach((element) {
    //       Hive.box('downloads').put(
    //         element.id,
    //         element,
    //       );
    //     });
    //     _preferencesProvider.setBool(Preferences.DB_POPULATED, true);
    //   }
    // }
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onBoarding();
    awaitPopulateSongs();
  }

  void onBoarding() async {
    if (!await _preferencesProvider.getBool(Preferences.ON_BOARDING_DONE))
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    _preferencesProvider.setBool(Preferences.ON_BOARDING_DONE, true);
  }

  awaitPopulateSongs() async {
    await SplashScreen.populateSongsIntoDB();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScaffold()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Image.asset(
          'assets/images/logo_dark.png',
          width: 160,
          height: 160,
        ));
  }
}
