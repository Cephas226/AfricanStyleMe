import 'package:flutter/material.dart';
import 'package:getx_app/model/tiktok.dart';
import 'package:getx_app/model/video_model.dart';
import 'package:getx_app/widget/leftItems.dart';
import 'package:getx_app/widget/rightItems.dart';
import 'package:getx_app/widget/videoPlayer.dart';


class TikTokVideox extends StatelessWidget {
  final Video video;

  const TikTokVideox({@required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TikTokVideoPlayer(url: video.url[0]),
          title(),
          /*RightItems(
            comments: data.itemInfos.commentCount.toString(),
            userImg: data.authorInfos.covers[0],
            favorite: data.itemInfos.diggCount,
            coverImg: data.musicInfos.covers[0],
          ),*/
           /*LeftItems(
            description: data.itemInfos.text,
            musicName: data.musicInfos.musicName,
            authorName: data.musicInfos.authorName,
            userName: data.authorInfos.uniqueId,
          )*/
        ],
      ),
    );
  }

  Widget title() => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 28.0),
      child: Text(
        "Trending | For You",
        style: TextStyle(color: Colors.white, fontSize: 19.0),
      ),
    ),
  );
}