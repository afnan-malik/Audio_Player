import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:untitled1/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body:FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          ignoreCase: true,
          uriType: UriType.EXTERNAL
      ),
        builder: (context,item) {
          if(item.data==null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(item.data!.isEmpty){
            return Text("no song found");
          }
          return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context,index){
                return ListTile(
                  onTap: () {
                    final songData = item.data![index];
                    if (songData != null) {
                      // Sending current song and the whole song list to the Player screen
                      Get.toNamed(Routes.PLAYER, arguments: {
                        'currentSong': songData,
                        'songList': item.data!, // Pass the entire song list
                      });
                    } else {
                      print("Selected song data is null");
                    }
                  },

                  leading:QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget:  Icon(Icons.music_note),
                  ),
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text(item.data![index].artist.toString()),
                  trailing:  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {}
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      )];
                    },
                  ),
                );
              }
          );
        },)
    );
  }
}
