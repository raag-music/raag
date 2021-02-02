import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/dark_theme_provider.dart';
import 'package:raag/widgets/my_music_list.dart';
import 'package:raag/view/download_music.dart';
import 'package:raag/widgets/theme_button.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          brightness:
              themeProvider.darkTheme ? Brightness.light : Brightness.dark,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadMusic(url: ''),
                  ))),
          actions: <Widget>[
            ThemeButton(),
          ],
          title: Center(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              'assets/images/musical.png',
              width: 40,
              height: 40,
            ),
          ))),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [MyMusicList()],
            ),
          ),
        ],
      ),
    );
  }
}
