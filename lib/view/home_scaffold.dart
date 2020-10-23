import 'package:flutter/material.dart';
import 'package:raag/view/My_Music_List.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
