import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/widgets/seekbar.dart';

class PlayBackControls extends StatefulWidget {
  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    playFABController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    playFABController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor.withOpacity(0.65),
              ),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                          child: RawMaterialButton(
                              shape: CircleBorder(),
                              child: Center(
                                child: AnimatedIcon(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  icon: AnimatedIcons.play_pause,
                                  size: 50,
                                  progress: playFABController,
                                ),
                              ),
                              elevation: 0,
                              onPressed: () {
                                if (provider.playerState == PlayerState.playing) {
                                  playFABController.reverse();
                                  provider.playerState = PlayerState.paused;
                                  provider.audioManagerInstance.playOrPause();
                                } else if (provider.playerState ==
                                    PlayerState.paused) {
                                  playFABController.forward();
                                  provider.playerState = PlayerState.playing;
                                  provider.audioManagerInstance.playOrPause();
                                } else {}
                              }),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                              provider.slider = 0;
                              playFABController.reverse();
                              provider.audioManagerInstance.stop();
                              provider.playerState = PlayerState.stopped;
                            },
                            child: Icon(
                              Icons.stop,
                              color: Theme.of(context).colorScheme.secondary,
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
          ),
        ),
      ],
    );
  }
}
