import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/widget/customicon.dart';
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
                      height: 420.0,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: Mclipper(),
                            child: Container(
                              height: 370.0,
                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 10.0),
                                    blurRadius: 10.0)
                              ]),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset("assets/images/banner.png",
                                      fit: BoxFit.cover, width: double.infinity),
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              const Color(0x00000000),
                                              const Color(0xD9333333)
                                            ],
                                            stops: [
                                              0.0,
                                              0.9
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(0.0, 1.0))),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 120.0, left: 95.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "WATCH BEFORE EVERONE",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontFamily: "SF-Pro-Display-Bold"),
                                          ),
                                          Text(
                                            "The Punisher: Season 2",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 45.0,
                                                fontFamily: "SF-Pro-Display-Bold"),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 370.0,
                            right: -20.0,
                            child: FractionalTranslation(
                              translation: Offset(0.0, -0.5),
                              child: Row(
                                children: <Widget>[
                                  FloatingActionButton(
                                    backgroundColor: Colors.white,
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFFE52020),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: Color(0xFFE52020),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 80.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Watch Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontFamily: "SF-Pro-Display-Bold"),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(CustomIcons.back_icon,
                                                size: 25.0, color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}