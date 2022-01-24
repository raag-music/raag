import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';

class SeekBar extends StatefulWidget {
  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);
    return StreamBuilder<MediaItem?>(
        stream: provider.audioHandler?.mediaItem,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          }
          final duration = snapshot.data?.duration;
          return StreamBuilder<Duration>(
              stream: provider.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Text(
                        formatDuration(position),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2,
                                thumbColor:
                                    Theme.of(context).colorScheme.secondary,
                                overlayColor: Theme.of(context).dividerColor,
                                thumbShape: RoundSliderThumbShape(
                                  disabledThumbRadius: 3,
                                  enabledThumbRadius: 5,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 10,
                                ),
                                activeTrackColor:
                                    Theme.of(context).colorScheme.secondary,
                                inactiveTrackColor:
                                    Theme.of(context).dividerColor,
                              ),
                              child: Slider(
                                value: (position?.inMilliseconds ?? 0)
                                        .toDouble() /
                                    (duration?.inMilliseconds ?? 1).toDouble(),
                                onChangeEnd: (value) {
                                  debugPrint(
                                      'Duration: ${(Duration(milliseconds: (duration!.inMilliseconds * value).round()))} ');
                                  provider.audioHandler?.seek(Duration(
                                      milliseconds:
                                          (duration.inMilliseconds * value)
                                              .round()));
                                },
                                onChanged: (double value) {},
                                // onChangeEnd: (value) => provider.seekTo(value),
                              )),
                        ),
                      ),
                      Text(
                        formatDuration(duration ?? Duration.zero),
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                );
              });
        });
  }
}
