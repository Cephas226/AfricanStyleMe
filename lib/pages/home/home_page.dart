import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/widget/details.dart';
import 'package:getx_app/widget/network_image.dart';
import 'package:getx_app/widget/photohero.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../main.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(icon: Icon(Icons.photo_camera)),
                Tab(icon: Icon(Icons.stars)),
                Tab(icon: Icon(Icons.video_library_sharp)),
              ],
            ),
            title: Text(
              controller.title,
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0,
            backgroundColor: Colors.indigo,
          ),
          drawer: MainDrawer(),
          body: TabBarView(
            children: [
              SafeArea(
                child: new Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildChip('Récent', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Mieux notés', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Popuplaires', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Aléatoire', Colors.grey),
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                          },
                        ),
                      )),
                    )
                  ],
                ),
              ),
              SafeArea(
                child: new Column(
                  children: <Widget>[
                    Stack(children: [
                      Row(
                        children: [
                          Flexible(child:  Container(
                            width: double.infinity,
                            height: 650,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(1)),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                  "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/3.jpg?alt=media&token=d8d4dc46-39a2-472b-a37d-c4dd83ef518b",
                                  fit: BoxFit.fill),
                            ),
                          ))
                        ],
                      ),
                      Positioned(
                        left: 80,
                        top: 600,
                        child:
                        Container(
                          child:Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                          decoration: new BoxDecoration(
                              color: Colors.white10,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12))
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              SafeArea(
                child: new Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.indigoAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.stars,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.video_library_sharp,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildChip('Récent', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Mieux notés', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Popuplaires', Colors.grey),
                          SizedBox(width: 10),
                          _buildChip('Aléatoire', Colors.grey),
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                          },
                        ),
                      )),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

Widget _buildChip(String label, Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(10.0),
  );
}
