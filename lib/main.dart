import 'package:flutter/material.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/home_scaffold.dart';
import 'package:raag/provider/theme.dart';

var audioManagerInstance = AudioManager.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
  //   audioManagerInstance.onEvents((events, args) {
  //     switch (events) {
  //       case AudioManagerEvents.start:
  //         _slider = 0;
  //         break;
  //       case AudioManagerEvents.seekComplete:
  //         _slider = audioManagerInstance.position.inMilliseconds /
  //             audioManagerInstance.duration.inMilliseconds;
  //         setState(() {
  //
  //         });
  //         break;
  //       case AudioManagerEvents.playstatus:
  //         isPlaying = audioManagerInstance.isPlaying;
  //         setState(() {
  //
  //         });
  //         break;
  //       case AudioManagerEvents.timeupdate:
  //         _slider = audioManagerInstance.position.inMilliseconds /
  //             audioManagerInstance.duration.inMilliseconds;
  //         audioManagerInstance.updateLrc(args["position"].toString());
  //         setState(() {
  //
  //         });
  //         break;
  //       case AudioManagerEvents.ended:
  //         audioManagerInstance.next();
  //         setState(() {
  //
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        title: title,
        home: HomeScaffold()
    );
  }
}
