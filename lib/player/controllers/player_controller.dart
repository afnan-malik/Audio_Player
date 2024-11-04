import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer=AudioPlayer();
  final SongModel item = Get.arguments;
  final isPlaying = false.obs;
  var duration = "".obs;
  var position = "".obs;


  @override
  void onInit() {
    super.onInit();
    _initAudioPlayer();
  }
  updatePosition(){
    audioPlayer.durationStream.listen((d){
      duration.value=d.toString().split(".")[0];
    });
    audioPlayer.positionStream.listen((p){
      position.value=p.toString().split(".")[0];
    });
  }

  void _initAudioPlayer() {
    // Listen to the player's playback state and update `isPlaying`
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }


  Future<void> playPauseSong() async {
    try {
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(item.uri.toString())),
        );
        await audioPlayer.play();
        updatePosition();
      }
    } on Exception catch (e) {
      log("Error loading audio: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

}
