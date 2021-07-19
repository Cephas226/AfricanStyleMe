
import 'package:flutter/material.dart';
import 'package:getx_app/widget/orientation/video_player_fullscreen_widget.dart';
import 'package:video_player/video_player.dart';

class PortraitPlayerWidget extends StatefulWidget {
  @override
  _PortraitPlayerWidgetState createState() => _PortraitPlayerWidgetState();
}
class _PortraitPlayerWidgetState extends State<PortraitPlayerWidget> {
  VideoPlayerController controller;
  final urlPortraitVideo = 'https://firebasestorage.googleapis.com/v0/b/africanstyle-15779.appspot.com/o/2020%20AFRICAN%20DRESSES%20MOST%20STYLISH%20AND%20FLAWLESS%20AFRICAN%20ANKARA%20STYLES%20FOR%20BEAUTIFUL%20LADIES.mp4?alt=media&token=84b246f7-e450-4c74-bfe8-da7061b86fef';


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
