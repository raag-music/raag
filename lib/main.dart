import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/provider/settings_provider.dart';
import 'package:raag/view/splash_screen.dart';

import 'model/strings.dart';
import 'provider/theme.dart';

PlayerProvider playerProvider = new PlayerProvider();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingsProvider settingsProvider = new SettingsProvider();

  @override
  void initState() {
    super.initState();
    initSettings();
    playerProvider.setUpAudio();
  }

  void initSettings() async {
    settingsProvider.darkTheme = await settingsProvider.sharedPreference
        .getBool(Preferences.THEME_STATUS);
    settingsProvider.appStorage = await settingsProvider.sharedPreference
        .getBool(Preferences.DOWNLOAD_DIRECTORY);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => settingsProvider),
        ChangeNotifierProvider<PlayerProvider>(
          create: (_) => playerProvider,
        )
      ],
      child: Consumer<SettingsProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(settingsProvider.darkTheme, context),
            title: appName,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
