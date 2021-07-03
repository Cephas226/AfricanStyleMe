import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/widget/details.dart';
import 'package:getx_app/widget/network_image.dart';
import 'package:getx_app/widget/photohero.dart';
import 'package:transparent_image/transparent_image.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/3.jpg?alt=media&token=d8d4dc46-39a2-472b-a37d-c4dd83ef518b',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/4.jpg?alt=media&token=00963d94-01cf-4d46-adc8-3f282460be3b',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/7.jpg?alt=media&token=4d5e8cfb-8bd5-43dd-90f3-6c54e4113b9c',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/8.jpg?alt=media&token=adc21471-2539-4a66-aa9d-bd4c769d839d'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.title,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: new Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _buildChip('Gamer', Color(0xFFff6666)),
                  _buildChip('Hacker', Color(0xFF007f5c)),
                  _buildChip('Developer', Color(0xFF5f65d3)),
                  _buildChip('Racer', Color(0xFF19ca21)),
                  _buildChip('Traveller', Color(0xFF60230b)),
                ],
              ),
            ),
            Expanded(
              child: Scaffold(
                  body: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemCount: imageList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return ModelPage();
                                    }));
                          },
                          child:  Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: imageList[index],
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                    staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(
                  1, index.isEven ? 1.2 : 1.8);
                  },),
              )),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildChip(String label, Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}