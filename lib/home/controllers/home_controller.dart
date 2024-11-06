import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();

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
}

