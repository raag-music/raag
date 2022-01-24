import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'package:raag/provider/settings_provider.dart';
import 'package:raag/view/download_music.dart';
import 'package:raag/view/playback_controls.dart';
import 'package:raag/view/settings.dart';
import 'package:raag/widgets/my_music_list.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScaffold extends StatefulWidget {
  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    handleIntent();
  }

  void handleIntent() {
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getTextStream().listen((String value) async {
      debugPrint("Received URL: $value");
      // Download if YouTube URL is received
      if (isValidYouTubeURL(value)) launchDownloader(value);
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      debugPrint("Received URL: $value");
      if (value != null) {
        if (isValidYouTubeURL(value)) launchDownloader(value);
      }
    });
  }

  void launchDownloader(String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DownloadMusic(url: url),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingsProvider>(context);

    return WillPopScope(
      onWillPop: () {
        if (panelController.isAttached == true &&
            panelController.isPanelOpen == true) {
          panelController.close();
          return Future.value(false);
        } else
          return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            systemOverlayStyle: themeProvider.darkTheme
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.download_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DownloadMusic(url: ''),
                    ))),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      )))
            ],
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: themeProvider.darkTheme
                  ? Image.asset(
                      'assets/images/logo_light.png',
                      width: 35,
                      height: 40,
                    )
                  : Image.asset(
                      'assets/images/logo_dark.png',
                      width: 35,
                      height: 40,
                    ),
            ))),
        body: Stack(
          children: <Widget>[
            MyMusicList(),
            PlayBackControls(
              panelController: panelController,
            )
          ],
        ),
      ),
    );
  }
}
