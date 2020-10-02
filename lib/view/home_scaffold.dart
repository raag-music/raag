import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/My_Music_List.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Icon(Icons.music_note),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Text(
                myMusic,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            MyMusicList()
          ],
        ),
      ),
    );
  }
}
