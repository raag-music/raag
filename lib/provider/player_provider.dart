import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';

enum PlayerState { stopped, playing, paused }

class PlayerProvider extends ChangeNotifier {
  Duration duration;
  Duration position;
  PlayerState playerState;
  double slider = 0.0;
  var audioManagerInstance = AudioManager.instance;

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  void setUpAudio() {
    playerState = PlayerState.stopped;
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          notifyListeners();
          break;
        case AudioManagerEvents.playstatus:
          notifyListeners();
          break;
        case AudioManagerEvents.timeupdate:
          slider = audioManagerInstance.position.inMilliseconds /
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
}
