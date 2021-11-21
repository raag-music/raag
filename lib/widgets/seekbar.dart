import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';

class SeekBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);
    return Row(
      children: <Widget>[
        Text(
          formatDuration(provider.position),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  overlayColor: Theme.of(context).dividerColor,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 3,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveTrackColor: Theme.of(context).dividerColor,
                ),
                child: Slider(
                  value: (provider.slider >= 0 && provider.slider <= 1)
                      ? provider.slider
                      : 0,
                  onChanged: (value) {
                    provider.slider = value;
                  },
                  onChangeEnd: (value) => provider.seekTo(value),
                )),
          ),
        ),
        Text(
          formatDuration(provider.duration),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
