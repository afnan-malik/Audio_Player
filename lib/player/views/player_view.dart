import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_controller.dart';

class PlayerView extends GetView<PlayerController> {
  const PlayerView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      init: PlayerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            title: const Text('PlayerView'),
            centerTitle: true,
          ),
            body: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: QueryArtworkWidget(
                      id: controller.item!.id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(Icons.music_note,color: Colors.white,size: 40,),
                    )
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  child: Column(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(12.0),
                         child: Text(
                          controller.item!.displayName,
                          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                               ),
                       ),
                       const SizedBox(
                        height: 20,
                      ),
                       Text(
                         controller.item!.artist.toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(()=>Row(
                        children: [
                          Text(
                            controller.position.value,
                            style:  const TextStyle(color: Colors.black),
                          ),
                          Expanded(child:
                          Slider(
                              inactiveColor: Colors.black,
                              activeColor: Colors.yellow,
                              thumbColor: Colors.red,
                              min: const Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller.changeDuration(newValue.toInt());
                                newValue=newValue;
                              }
                          )),
                          Text(
                            controller.duration.value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: () {
                            controller.previousSong();
                          }, icon: const Icon(Icons.skip_previous, size: 40)),
                          CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.black,
                              child: Transform.scale(
                                scale: 2.5,
                                child:IconButton(
                                  onPressed: () {
                                    controller.prepareAudio();
                                    controller.playPauseSong();
                                  },
                                  icon: Obx(() => Icon(
                                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white70,
                                  )),
                                ),
                              )),
                          IconButton(onPressed: (){
                            controller.nextSong();
                          }, icon: const Icon(Icons.skip_next, size: 40)),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ));
      }
    );
  }
}
