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
    final provider = Provider.of<PlayerProvider>(context);

    return SlidingUpPanel(
      collapsed: CollapsedControls(
        provider: provider,
        panelController: panelController,
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
              children: [
                Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
