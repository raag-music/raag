import 'package:flutter/material.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'seekbar.dart';

class CollapsedControls extends StatelessWidget {
  const CollapsedControls({
    Key key,
    @required this.provider,
    @required this.panelController,
  }) : super(key: key);

  final PlayerProvider provider;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onPressed: () async => await panelController.open(),
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 35,
                      ),
                    ),
                    elevation: 4,
                  )),
                ),
                SizedBox(
                  width: 30,
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
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                        elevation: 0,
                        onPressed: () => provider.previous()),
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
                          color: Theme.of(context).colorScheme.secondary,
                          icon: AnimatedIcons.play_pause,
                          size: 50,
                          progress: playPauseController,
                        ),
                      ),
                      elevation: 0,
                      onPressed: () {
                        if (provider.playerState == PlayerState.playing) {
                          playPauseController.reverse();
                          provider.playerState = PlayerState.paused;
                          provider.pause();
                        } else if (provider.playerState == PlayerState.paused) {
                          playPauseController.forward();
                          provider.playerState = PlayerState.playing;
                          provider.resume();
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
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                        elevation: 0,
                        onPressed: () => provider.next()),
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
                      playPauseController.reverse();
                      provider.stop();
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
    );
  }
}
