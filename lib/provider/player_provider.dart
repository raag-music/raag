import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:raag/model/music_model.dart';

enum PlayerState { stopped, playing, paused }

class PlayerProvider extends ChangeNotifier {
  PlayerState playerState;
  Song nowPlaying;

  double _slider = 0.0;
  AudioManager audioManagerInstance = AudioManager.instance;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get position => audioManagerInstance.position;
  get duration => audioManagerInstance.duration;

  get slider => _slider;
  set slider(double value) {
    _slider = value;
    notifyListeners();
  }

  void setUpAudio() {
    playerState = PlayerState.stopped;
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          notifyListeners();
          break;
        case AudioManagerEvents.playstatus:
          notifyListeners();
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          notifyListeners();
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          notifyListeners();
          break;
        default:
          break;
      }
    });
  }

  void play(Song song) {
    if (audioManagerInstance.isPlaying) audioManagerInstance.toPause();
    playerState = PlayerState.playing;
    audioManagerInstance
        .start("file://${song.filePath}", song.title,
            desc: song.displayName,
            auto: true,
            cover: song.albumArtwork ?? 'assets/images/musical.png')
        .then((err) {
      print(err);
    });
    nowPlaying = song;
    notifyListeners();
  }

  void pause() => audioManagerInstance.toPause();

  void resume() => audioManagerInstance.playOrPause();

  void next() => audioManagerInstance.next();

  void previous() => audioManagerInstance.previous();

  void seekTo(double value) {
    Duration msec = Duration(
        milliseconds:
            (audioManagerInstance.duration.inMilliseconds * value).round());
    audioManagerInstance.seekTo(msec);
  }

  void stop() {
    audioManagerInstance.stop();
    playerState = PlayerState.stopped;
    _slider = 0.0;
    nowPlaying = null;
    notifyListeners();
    disposePlayer();
  }

  void disposePlayer() {}
}
