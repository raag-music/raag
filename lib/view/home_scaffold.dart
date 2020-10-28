import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:raag/DarkThemeProvider.dart';
import 'package:raag/view/My_Music_List.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (themeChange.darkTheme == true) {
                  themeChange.darkTheme = false;
                } else {
                  themeChange.darkTheme = true;
                }
              },
              child: Icon(Icons.wb_sunny_outlined),
            ),
          ],
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset('assets/images/musical.png',
            width: 40,
            height: 40,),
          )
        )
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyMusicList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
