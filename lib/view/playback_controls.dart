import 'package:flutter/material.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/widgets/seekbar.dart';

import '../main.dart';

class PlayBackControls extends StatefulWidget {
  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SeekBar(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    new Container(
                      height: 50,
                      width: 50,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2.5,
                        ),
                      ),
                      child: new Center(
                        child: RawMaterialButton(
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.skip_previous_outlined,
                              color: Theme.of(context).accentColor,
                              size: 30,
                            ),
                            elevation: 0,
                            onPressed: () {
                              audioManagerInstance.previous();
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    new Container(
                      height: 70,
                      width: 70,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2.5,
                        ),
                      ),
                      child: new Center(
                        child: RawMaterialButton(
                            shape: CircleBorder(),
                            child: AnimatedIcon(
                              color: Theme.of(context).accentColor,
                              icon: AnimatedIcons.play_pause,
                              size: 50,
                              progress: playFABController,
                            ),
                            elevation: 0,
                            onPressed: () {
                              audioManagerInstance.isPlaying
                                  ? playFABController.reverse()
                                  : playFABController.forward();
                              audioManagerInstance.playOrPause();
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    new Container(
                      height: 50,
                      width: 50,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2.5,
                        ),
                      ),
                      child: new Center(
                        child: RawMaterialButton(
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.skip_next_outlined,
                              color: Theme.of(context).accentColor,
                              size: 30,
                            ),
                            elevation: 0,
                            onPressed: () {
                              audioManagerInstance.next();
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    new Container(
                      height: 40,
                      width: 40,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2.5,
                        ),
                      ),
                      child: new Center(
                          child: RawMaterialButton(
                        shape: CircleBorder(),
                        onPressed: () {
                          audioManagerInstance.stop();
                          playFABController.reverse();
                        },
                        child: Icon(
                          Icons.stop,
                          color: Theme.of(context).accentColor,
                        ),
                        elevation: 4,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
