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
  SettingsProvider themeChangeProvider = new SettingsProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    playerProvider.setUpAudio();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.sharedPreference
        .getBool(Preferences.THEME_STATUS);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => themeChangeProvider),
        ChangeNotifierProvider<PlayerProvider>(create: (_) => playerProvider,)
      ],
      child: Consumer<SettingsProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            title: appName,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
