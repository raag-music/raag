import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/widgets/collapsed_controls.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayBackControls extends StatefulWidget {
  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls> 
    with TickerProviderStateMixin {
  PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    playPauseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    playPauseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return SlidingUpPanel(
      collapsed: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: CollapsedControls(
            provider: playerProvider,
            panelController: panelController,
          ),
        ),
      ),
      renderPanelSheet: false,
      controller: panelController,
      minHeight: MediaQuery.of(context).size.height * 0.2,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      panel: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.65),
          ),
          child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Container(
                      width: sw * .8,
                      child: Text(
                        playerProvider.nowPlaying?.title ?? 'Not playing',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: sh * .036),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                    ),
                  ),
                  Container(
                      color: Theme.of(context).colorScheme.secondary,
                      width: sh * .35,
                      height: sh * .35,
                      child: getAlbumArt(playerProvider.nowPlaying,
                          Theme.of(context).dividerColor)),
                ],
              )),
        ),
      ),
    );
  }
}
