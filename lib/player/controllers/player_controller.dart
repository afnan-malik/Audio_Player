import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer=AudioPlayer();
   SongModel? item;
  late final List<SongModel> songList;

  final isPlaying = false.obs;
  var duration = "".obs;
  var position = "".obs;
  var max = 0.0.obs;
  var value = 0.0.obs;


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    item = args['currentSong'];
    songList = List<SongModel>.from(args['songList']);

    _initAudioPlayer();
    updatePosition();
    prepareAudio();
  }

  updatePosition(){
    audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration.value = d.toString().split(".")[0];
        max.value = d.inSeconds.toDouble();
      }
    });
    audioPlayer.positionStream.listen((p){
      position.value=p.toString().split(".")[0];
      value.value=p.inSeconds.toDouble();
    });
  }
  changeDuration(seconds){
    var duration =Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void _initAudioPlayer() {

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }


  void nextSong() {
    final currentIndex = songList.indexOf(item!);
    if (currentIndex < songList.length - 1) {
      item = songList[currentIndex + 1];
      prepareAudio();
      audioPlayer.play();
    }
  }

  void previousSong() {
    final currentIndex = songList.indexOf(item!);
    if (currentIndex > 0) {
      item = songList[currentIndex - 1];
      prepareAudio();
      audioPlayer.play();
    }
  }



  Future<void> playPauseSong() async {
    try {
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(item!.uri.toString())),
        );
        await audioPlayer.play();
      }
    } on Exception catch (e) {
      log("Error loading audio: $e");
    }
  }
  /// loadAudio
  Future<void> prepareAudio() async {
    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(item!.uri.toString())));
    } catch (e) {
      log("Error preparing audio: $e");
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
