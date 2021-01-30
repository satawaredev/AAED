
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';


class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  CachedVideoPlayerController controller;
  @override
  void initState() {
    controller = CachedVideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: controller.value != null && controller.value.initialized
              ? AspectRatio(
            child: CachedVideoPlayer(controller),
            aspectRatio: controller.value.aspectRatio,
          )
              : Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}