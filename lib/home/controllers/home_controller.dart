import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
 final AudioPlayer audioPlayer=AudioPlayer();


  @override
  void onInit() {
    super.onInit();
    // requestPermissions();
  }

  playSong(String? uri)async{
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!))
      );
      audioPlayer.play();
    } on Exception catch (e) {
      // Handle errors
      log("...........................................Error loading audio: $e");
    }
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
  }


  // Future<List<SongModel>> fetchSongs() async {
  //   try {
  //     return await audioQuery.querySongs(
  //       sortType: null,
  //       orderType: OrderType.ASC_OR_SMALLER,
  //       ignoreCase: true,
  //       uriType: UriType.EXTERNAL,
  //     );
  //   } catch (e) {
  //     throw Exception("Failed to fetch songs: $e");
  //   }
  // }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}