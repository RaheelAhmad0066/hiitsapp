import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class AudioController extends GetxController {
  final FlutterSoundPlayer _flutterSoundPlayer = FlutterSoundPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  var filePath = Rxn<String>();
  var fileName = Rxn<String>();
  var isPlaying = false.obs;
  var isBackgroundPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _flutterSoundPlayer.openPlayer();
    _backgroundPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerMode.lowLatency) {
        isBackgroundPlaying.value = false;
        _backgroundPlayer.setVolume(1.0); // Reset volume to normal
      }
    });

    // Handle background tasks
    _backgroundPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerMode.lowLatency) {
        isBackgroundPlaying.value = false;
      }
    });
  }

  @override
  void onClose() {
    _flutterSoundPlayer.closePlayer();
    _backgroundPlayer.dispose();
    super.onClose();
  }

  Future<void> playMusic() async {
    if (filePath.value != null && File(filePath.value!).existsSync()) {
      // Pause background music if it's playing
      if (isBackgroundPlaying.value) {
        await _backgroundPlayer.setVolume(0.2); // Decrease volume by 80%
      }

      await _flutterSoundPlayer.startPlayer(
        fromURI: filePath.value!,
        codec: Codec.defaultCodec,
        whenFinished: () {
          isPlaying.value = false;
        },
      );
      isPlaying.value = true;
    } else {
      print("File not found or not selected.");
    }
  }

  Future<void> pauseMusic() async {
    if (isPlaying.value) {
      await _flutterSoundPlayer.pausePlayer();
      isPlaying.value = false;
      // Reset background music volume to normal if needed
      if (isBackgroundPlaying.value) {
        await _backgroundPlayer.setVolume(1.0); // Reset volume to normal
      }
    }
  }

  Future<void> selectMusic(String? path, String? name) async {
    if (path != null) {
      filePath.value = path;
      fileName.value = name;
    }
  }

  Future<void> playBackgroundMusic(String url) async {
    await _backgroundPlayer.setVolume(1.0); // Set initial volume
    await _backgroundPlayer.play(url as Source);
    isBackgroundPlaying.value = true;
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
    isBackgroundPlaying.value = false;
    await _backgroundPlayer.setVolume(1.0); // Reset volume to normal
  }

  // Function to set volume to 20% and reset it
  // Function to set volume to 20% and reset it
  Future<void> toggleVolume() async {
    if (isPlaying.value) {
      // If music is playing, adjust volume to 20% of maximum
      await _flutterSoundPlayer.setVolume(0.2); // Set volume to 20% of maximum
    } else {
      // Reset volume to normal (100%)
      await _flutterSoundPlayer.setVolume(3.0); // Set volume to 100% of maximum
    }
  }
}
