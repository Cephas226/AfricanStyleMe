import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/videos/video_page.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../main.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/4.jpg?alt=media&token=00963d94-01cf-4d46-adc8-3f282460be3b',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/7.jpg?alt=media&token=4d5e8cfb-8bd5-43dd-90f3-6c54e4113b9c',
    'https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/8.jpg?alt=media&token=adc21471-2539-4a66-aa9d-bd4c769d839d'
  ];
  @override
  Widget build(BuildContext context) {
    Future<List> fetchAds() async {
      final response =
          await http.get('https://myafricanstyle.herokuapp.com/product');

      if (response.statusCode == 200) return json.decode(response.body);
      return [];
    }

    CarouselController nextCarouselController = new CarouselController();
    final HomeController _controller = Get.put(HomeController());

    final List<Widget> imageSliders =
    _controller.photoList.map((e) => ClipRRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: e.url,
              fit: BoxFit.fill),
          Positioned(
            left: 80,
            top: 590,
            child: Container(
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      nextCarouselController.nextPage();
                    },
                  )
                ],
              ),
              decoration: new BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(
                      Radius.circular(12))),
            ),
          ),
        ],
      ),
    )).toList();


    final List<Widget> videoSliders =
    _controller.photoList.map((e) => ClipRRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Obx(() {
            if (_controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return
              VideosPage();
            /*Image.network("https://myafricanstyle.herokuapp.com/files/1d732272-3238-4b81-9d7f-a7ffca75cc76",
                width: double.infinity, fit: BoxFit.fill);*/
          })
        ],
      ),
    )).toList();


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
                      child: FutureBuilder<List>(
                          future: fetchAds(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return new Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new StaggeredGridView.count(
                                  crossAxisCount: 4,
                                  padding: const EdgeInsets.all(2.0),
                                  children: snapshot.data.map<Widget>((item) {
                                    return new Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child:
                                            Stack(
                                              fit: StackFit.passthrough,
                                              overflow: Overflow.visible,
                                              children: [
                                                FadeInImage.memoryNetwork(
                                                    placeholder: kTransparentImage,
                                                    image: item["url"],
                                                    fit: BoxFit.cover),
                                                Positioned(
                                                  left: 160,
                                                  top: 50,
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.remove_red_eye_sharp,
                                                          color: Colors.black,
                                                        ),
                                                        Icon(
                                                          Icons.share,
                                                          color: Colors.black,
                                                        ),
                                                        Icon(
                                                          Icons.file_download,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                    decoration: new BoxDecoration(
                                                        color: Colors.white10,
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(12))),
                                                  ),
                                                ),
                                              ],
                                            )
                                      ),
                                    );
                                  }).toList(),
                                  staggeredTiles: snapshot.data
                                      .map<StaggeredTile>(
                                          (_) => StaggeredTile.fit(2))
                                      .toList(),
                                  mainAxisSpacing: 3.0,
                                  crossAxisSpacing: 4.0, // add some space
                                ),
                              );
                            } else {
                              return Center(
                                  child:
                                      new CircularProgressIndicator()); // If there are no data show this
                            }
                          }),
                    )
                  ],
                ),
              ),
              Obx(() {
                if (_controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 490,
                        scrollDirection: Axis.vertical,
                        initialPage: 2,
                        viewportFraction: 1,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                      ),
                      items: imageSliders,
                    ));
              }),
              Obx(() {
                if (_controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 490,
                        scrollDirection: Axis.vertical,
                        initialPage: 2,
                        viewportFraction: 1,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                      ),
                      carouselController: nextCarouselController,
                      items: videoSliders,
                    ));
              })
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