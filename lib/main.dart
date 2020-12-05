import 'package:flutter/material.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/theme.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/home_scaffold.dart';
import 'package:raag/provider/audio_helper.dart';
import 'dart:async';
import 'DarkThemeProvider.dart';

var audioManagerInstance = AudioManager.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          HomeScaffold()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        'assets/images/musical.png',
        width: 40,
        height: 40,
      )
    );
  }
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    setUpAudio();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  bool isPlaying = audioManagerInstance.isPlaying;

  void setUpAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              title: title,
              home: MyHomePage(),
              );
        },
      ),
    );
  }
}
