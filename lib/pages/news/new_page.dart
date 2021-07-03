import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/user_model.dart';
import 'package:getx_app/pages/news/news_controller.dart';
import 'package:getx_app/widget/photohero.dart';
import 'package:getx_app/widget/user.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FavorisPage extends GetView<FavorisController> {
  final List<UserModel> _userlist = [
    UserModel(1, "Anthony",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18"),
    UserModel(2, "Lea Agustine",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a"),
    UserModel(3, "Mickey",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18"),
    UserModel(4, "Donald Newman",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/8.jpg?alt=media&token=adc21471-2539-4a66-aa9d-bd4c769d839d"),
    UserModel(5, "Pedro Andrado",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
    UserModel(6, "Tony Stark",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "Favoris",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
        body: ListView(
          children: _userlist.map((user) => User(user)).toList(),
        ),
    );
  }
}
