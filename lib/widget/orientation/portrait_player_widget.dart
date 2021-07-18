
import 'package:flutter/material.dart';
import 'package:getx_app/widget/orientation/video_player_fullscreen_widget.dart';
import 'package:video_player/video_player.dart';

class PortraitPlayerWidget extends StatefulWidget {
  @override
  _PortraitPlayerWidgetState createState() => _PortraitPlayerWidgetState();
}
class _PortraitPlayerWidgetState extends State<PortraitPlayerWidget> {
  VideoPlayerController controller;
  final urlPortraitVideo = 'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4';


  @override
  void initState() {
    super.initState();
    controller =
    VideoPlayerController.network(urlPortraitVideo)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      VideoPlayerFullscreenWidget(controller: controller);
}
