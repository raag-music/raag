import 'package:flutter/material.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:provider/provider.dart';
import 'package:raag/Styles.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/home_scaffold.dart';

import 'DarkThemeProvider.dart';

var audioManagerInstance = AudioManager.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) {
      return themeChangeProvider;
    },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              title: title,
              home: HomeScaffold()
          );
        },
      ),);
  }
}