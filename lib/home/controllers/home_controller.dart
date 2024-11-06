import 'dart:developer';
import 'dart:io';
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
    requestPermissions();
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
  void deleteAudioFile(String fileUri) async {
    try {
      final filePath = Uri.parse(fileUri).path;
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        log("File deleted successfully");
      } else {
        log("File not found at path: $filePath");
      }
    } catch (e) {
      log("Error deleting file: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
