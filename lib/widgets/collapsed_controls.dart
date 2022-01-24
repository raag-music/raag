import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../provider/player_provider.dart';
import '../view/playback_controls.dart';
import 'seekbar.dart';

class CollapsedControls extends StatelessWidget {
  const CollapsedControls({
    Key? key,
    required this.provider,
    required this.panelController,
  }) : super(key: key);

  final PlayerProvider provider;
  final PanelController? panelController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SeekBar(),
            PlayBackControlButtons(
              provider: provider,
              isCollapsed: true,
              panelController: panelController,
            ),
          ],
        ),
      ),
    );
  }
}
