import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:raag/DarkThemeProvider.dart';
import 'package:raag/view/My_Music_List.dart';
import 'package:raag/widgets/ThemeButton.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
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
