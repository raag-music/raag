import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/widgets/seekbar.dart';

class PlayBackControls extends StatefulWidget {
  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls> {
  @override
  Widget build(BuildContext context) {
    var glowShadow = BoxShadow(
      color: Theme.of(context).accentColor.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 9,
      offset: Offset(0, 0), // changes position of shadow
    );
    final provider = Provider.of<PlayerProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              boxShadow: [glowShadow],
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
                              provider.audioManagerInstance.previous();
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
                              if (provider.audioManagerInstance.isPlaying) {
                                playFABController.reverse();
                                provider.playerState = PlayerState.paused;
                              }
                              else {
                                playFABController.forward();
                                provider.playerState = PlayerState.playing;
                              }
                              provider.audioManagerInstance.playOrPause();
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
                              provider.audioManagerInstance.next();
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
                              provider.audioManagerInstance.stop();
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
