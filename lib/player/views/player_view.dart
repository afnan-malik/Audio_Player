import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_controller.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Full rotation every 10 seconds
    );

    // Use the Get.find<PlayerController>() to listen for playback changes
    final playerController = Get.find<PlayerController>();
    playerController.audioPlayer.playingStream.listen((isPlaying) {
      if (isPlaying) {
        rotationController.repeat();
      } else {
        rotationController.stop();
      }
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      init: PlayerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF454444),
          appBar: AppBar(
            title: const Text(
              'PLAYit',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFFFF5555),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    // Add delete logic here
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Color(0xFFFF5555), shape: BoxShape.circle),
                    child: RotationTransition(
                      turns: rotationController,
                      child: QueryArtworkWidget(
                        id: controller.item!.id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: Center(
                          child: Image.asset(
                            'assets/images/2.png',
                            fit: BoxFit.fill,
                            scale: 1.5,
                          ),
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          controller.item!.displayName,
                          style: const TextStyle(color:  Color(0xFF454444), fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        controller.item!.artist.toString(),
                        style: const TextStyle(color: Color(0xFF454444), fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                            () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Expanded(
                              child: Slider(
                                inactiveColor:  const Color(0xFF454444),
                                activeColor: const Color(0xFFFF5555),
                                thumbColor: Colors.red,
                                min: const Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDuration(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: const TextStyle(color: Color(0xFF454444),)
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: controller.previousSong,
                            icon: const Icon(Icons.skip_previous, size: 40),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor:  const Color(0xFF454444),
                            child: Transform.scale(
                              scale: 2.5,
                              child: IconButton(
                                onPressed: () {
                                  controller.prepareAudio();
                                  controller.playPauseSong();
                                },
                                icon: Obx(
                                      () => Icon(
                                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: controller.nextSong,
                            icon: const Icon(Icons.skip_next, size: 40),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                controller.shuffle=!controller.shuffle;
                                controller.update();
                              },
                              icon: controller.shuffle?
                              const Icon(Icons.shuffle, size: 30)
                                  :const Icon(Icons.repeat, size: 30)
                            ),
                          ],
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
