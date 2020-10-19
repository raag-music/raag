import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/My_Music_List.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          myMusic,
          style: Theme.of(context).textTheme.headline1,
        ),
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
