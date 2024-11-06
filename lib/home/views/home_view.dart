
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
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text('PLAYit',style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
       backgroundColor:  const Color(0xFFFF5555),
        elevation:0,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(item.data!.isEmpty){
            return const Text("no song found");
          }
          return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 0),
                  child: Card(
                    elevation: 8,
                    child: ListTile(
                      tileColor: Colors.black12,
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
                        nullArtworkWidget:  const Icon(Icons.music_note,color: Colors.redAccent,),
                      ),
                      title: Text(item.data![index].displayNameWOExt,style: const TextStyle(fontSize: 14),),
                      subtitle: Text(item.data![index].artist.toString()),
                      trailing:  PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'delete') {
                            var file=item.data![index].uri;
                            controller.deleteAudioFile(file!);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          )];
                        },
                      ),
                    ),
                  ),
                );
              }
          );
        },)
    );
  }
}
