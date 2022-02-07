import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/download_provider.dart';

import 'model/SharedPreferences.dart';
import 'model/strings.dart';
import 'provider/db_provider.dart';
import 'provider/player_provider.dart';
import 'provider/settings_provider.dart';
import 'provider/theme.dart';
import 'view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initHive();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DBProvider dbProvider = new DBProvider();
  PlayerProvider playerProvider = new PlayerProvider();
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
    settingsProvider.downloadPath = (await settingsProvider.sharedPreference
            .getString(Preferences.DOWNLOAD_PATH) ??
        '/storage/emulated/0/Music/$appName');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => settingsProvider),
        ChangeNotifierProvider<PlayerProvider>(
          create: (_) => playerProvider,
        ),
        ChangeNotifierProvider<DBProvider>(create: (_) => DBProvider()),
        ChangeNotifierProvider<DownloadProvider>(
            create: (_) => DownloadProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (BuildContext context, value, Widget? child) {
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
