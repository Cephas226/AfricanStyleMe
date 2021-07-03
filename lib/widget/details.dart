import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_controller.dart';
class ModelPage extends GetView<ModelDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 450,
            child:  InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18"), fit: BoxFit.cover))
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
          Positioned(
            top: 380,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text("Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis.", textAlign: TextAlign.justify,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 365,
            left: 40,
            child: CircleAvatar(
                radius: 20.0,
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.share))),
          Positioned(
            top: 365,
            right: 40,
            child: CircleAvatar(
                radius: 20.0,
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.favorite_border)),
          )
        ],
      ),
    );
  }}