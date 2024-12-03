import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService instance = AudioService._internal();

  static get menuBgm => 'audio/bgm/menu.mp3';
  static get gameBgm => 'audio/bgm/game.mp3';

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  AudioService._internal();

  AudioPlayer get player => _audioPlayer;
  bool get isPlaying => _isPlaying;

  Future<void> playBackgroundMusic(String filePath, {bool loop = true}) async {
    if (!_isPlaying) {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the audio
      await _audioPlayer.play(AssetSource(filePath));
      _isPlaying = true;
    }
  }

  Future<void> stopBackgroundMusic() async {
    if (_isPlaying) {
      // _audioPlayer.
      await _audioPlayer.stop();
      await _audioPlayer.release();
      _isPlaying = false;
    }
  }

  Future<void> pauseBackgroundMusic() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (!_isPlaying) {
      await _audioPlayer.resume();
      _isPlaying = true;
    }
  }
}
