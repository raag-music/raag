import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/player_provider.dart';
import 'package:raag/widgets/animated_text.dart';
import 'package:raag/widgets/collapsed_controls.dart';
import 'package:raag/widgets/seekbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayBackControls extends StatefulWidget {
  final PanelController panelController;

  PlayBackControls({required this.panelController});
  @override
  _PlayBackControlsState createState() => _PlayBackControlsState();
}

class _PlayBackControlsState extends State<PlayBackControls>
    with TickerProviderStateMixin {
  PanelController? panelController;

  @override
  void initState() {
    super.initState();
    panelController = widget.panelController;
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
              child: StreamBuilder<MediaItem?>(
                  stream: playerProvider.audioHandler?.mediaItem,
                  builder: (context, snapshot) {
                    MediaItem? mediaItem = snapshot.data;
                    if (mediaItem == null) return const SizedBox();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    blurRadius: 25,
                                    spreadRadius: 5.0,
                                  ),
                                ]),
                            width: sh * .35,
                            height: sh * .35,
                            child: getMediaAlbumArt(mediaItem,
                                Theme.of(context).colorScheme.secondary)),
                        Center(
                          child: Container(
                              width: sw * .8,
                              child: AnimatedText(
                                text: '${mediaItem.title}',
                                pauseAfterRound: const Duration(seconds: 3),
                                showFadingOnlyWhenScrolling: false,
                                fadingEdgeEndFraction: 0.1,
                                fadingEdgeStartFraction: 0.1,
                                startAfter: const Duration(seconds: 2),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: sh * .036),
                              )
                              // child: Text(
                              //   mediaItem?.title ?? 'Not playing',
                              // style: Theme.of(context)
                              //     .textTheme
                              //     .headline1
                              //     .copyWith(fontSize: sh * .036),
                              // textAlign: TextAlign.center,
                              // softWrap: false,
                              // ),
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SeekBar(),
                            SizedBox(
                              height: 20,
                            ),
                            PlayBackControlButtons(
                                provider: playerProvider,
                                isCollapsed: false,
                                panelController: panelController),
                          ],
                        ),
                      ],
                    );
                  })),
        ),
      ),
    );
  }
}

class PlayBackControlButtons extends StatefulWidget {
  const PlayBackControlButtons({
    Key? key,
    required this.provider,
    required this.isCollapsed,
    required this.panelController,
  }) : super(key: key);

  final PlayerProvider provider;
  final bool isCollapsed;
  final PanelController? panelController;

  @override
  State<PlayBackControlButtons> createState() => _PlayBackControlButtonsState();
}

class _PlayBackControlButtonsState extends State<PlayBackControlButtons> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
        stream: widget.provider.audioHandler?.playbackState,
        builder: (context, snapshot) {
          final playbackState = snapshot.data;
          final playing = playbackState?.playing ?? true;

          if (playing)
            playPauseController.forward();
          else
            playPauseController.reverse();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isCollapsed
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: new BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2.5,
                        ),
                      ),
                      child: new Center(
                          child: RawMaterialButton(
                        shape: CircleBorder(),
                        onPressed: () async =>
                            await widget.panelController!.open(),
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 35,
                          ),
                        ),
                        elevation: 4,
                      )),
                    )
                  : SizedBox(),
              SizedBox(
                width: widget.isCollapsed ? 30 : 70,
              ),
              new Container(
                height: 50,
                width: 50,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
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
                      onPressed: () =>
                          widget.provider.audioHandler!.skipToPrevious()),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              new Container(
                height: 70,
                width: 70,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
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
                      if (!playing) {
                        playPauseController.forward();
                        widget.provider.audioHandler!.play();
                      } else if (playing) {
                        playPauseController.reverse();
                        widget.provider.audioHandler!.pause();
                      } else {
                        debugPrint('error');
                      }
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              new Container(
                height: 50,
                width: 50,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
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
                      onPressed: () =>
                          widget.provider.audioHandler!.skipToNext()),
                ),
              ),
              SizedBox(
                width: 35,
              ),
              new Container(
                height: 40,
                width: 40,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
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
                    widget.provider.stop();
                  },
                  child: Icon(
                    Icons.stop,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  elevation: 4,
                )),
              ),
            ],
          );
        });
  }
}
