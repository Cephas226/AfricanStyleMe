import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/videos/video_page.dart';
import 'package:getx_app/widget/photohero.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../main.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  List<String> imageList = [];
  @override
  Widget build(BuildContext context) {
    Future<List> fetchAds() async {
      final response =
          await http.get('https://myafricanstyle.herokuapp.com/product');

      if (response.statusCode == 200)
      return json.decode(response.body);
      return [];
    }

    CarouselController nextCarouselController = new CarouselController();
    final HomeController _controller = Get.put(HomeController());

    final List<Widget> imageSliders =
    _controller.photoList.map((e) => ClipRRect(
      child: Stack(
        children: <Widget>[
          Container(
            height: 600,
            width: double.infinity,
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: e.url,
                fit: BoxFit.fill),
          ),
          Positioned(
            left: 80,
            top: 500,
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
                    },
                  )
                ],
              ),
              decoration: new BoxDecoration(
                  color: Colors.white24,
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
          VideosPage()
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute<void>(
                                                        builder: (BuildContext context) {
                                                          return Scaffold(
                                                            floatingActionButton: FloatingActionButton(
                                                              onPressed: () {
                                                                // Add your onPressed code here!
                                                              },
                                                              child: const Icon(Icons.file_download),
                                                              backgroundColor: Colors.red,
                                                            ),
                                                            appBar: AppBar(
                                                              backgroundColor: Colors.indigo,
                                                              title: const Text('Details'),
                                                            ),
                                                            body:Stack(
                                                              fit:StackFit.passthrough,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets.all(0.0),
                                                                  height: double.infinity,
                                                                  color: Colors.indigo,
                                                                  child: PhotoHero(
                                                                    photo:  item["url"],
                                                                    width: double.infinity,
                                                                    height: double.infinity,
                                                                    onTap: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    bottom: 150,
                                                                    left: 10,
                                                                    child: Container(
                                                                      width: 200,
                                                                      decoration: new BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(12))),
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,

                                                                        children: [
                                                                          Icon(
                                                                            Icons.remove_red_eye_sharp,
                                                                            color: Colors.blue,
                                                                          ),
                                                                          Text("20",
                                                                            style: TextStyle(color: Colors.black),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 50,
                                                                          ),
                                                                          Icon(
                                                                            Icons.stars_rounded,
                                                                            color: Colors.blue,
                                                                          ),
                                                                          Text("4/5",
                                                                            style: TextStyle(color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                    ));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).buttonColor,
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child:
                                                    FadeInImage.memoryNetwork(
                                                        placeholder: kTransparentImage,
                                                        image: item["url"],
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 130,
                                                  top: 0,
                                                  child:
                                                     Center(
                                                       child:   Container(
                                                         child: Column(
                                                           children: [
                                                             IconButton(
                                                               onPressed: (){
                                                                 Navigator.of(context).push(MaterialPageRoute<void>(
                                                                     builder: (BuildContext context) {
                                                                       return Scaffold(
                                                                         floatingActionButton: FloatingActionButton(
                                                                           onPressed: () {
                                                                             // Add your onPressed code here!
                                                                           },
                                                                           child: const Icon(Icons.file_download),
                                                                           backgroundColor: Colors.red,
                                                                         ),
                                                                         appBar: AppBar(
                                                                           backgroundColor: Colors.indigo,
                                                                           title: const Text('Details'),
                                                                         ),
                                                                         body:Stack(
                                                                           fit:StackFit.passthrough,
                                                                           children: [
                                                                             Container(
                                                                               padding: const EdgeInsets.all(0.0),
                                                                               height: double.infinity,
                                                                               color: Colors.indigo,
                                                                               child: PhotoHero(
                                                                                 photo:  item["url"],
                                                                                 width: double.infinity,
                                                                                 height: double.infinity,
                                                                                 onTap: () {
                                                                                   Navigator.of(context).pop();
                                                                                 },
                                                                               ),
                                                                             ),
                                                                             Positioned(
                                                                                 bottom: 150,
                                                                                 left: 10,
                                                                                 child: Container(
                                                                                   width: 200,
                                                                                   decoration: new BoxDecoration(
                                                                                       color: Colors.white,
                                                                                       borderRadius: BorderRadius.all(
                                                                                           Radius.circular(12))),
                                                                                   child:
                                                                                   Row(
                                                                                     mainAxisAlignment: MainAxisAlignment.center,

                                                                                     children: [
                                                                                       Icon(
                                                                                         Icons.remove_red_eye_sharp,
                                                                                         color: Colors.blue,
                                                                                       ),
                                                                                       Text("20",
                                                                                         style: TextStyle(color: Colors.black),
                                                                                       ),
                                                                                       SizedBox(
                                                                                         width: 50,
                                                                                       ),
                                                                                       Icon(
                                                                                         Icons.stars_rounded,
                                                                                         color: Colors.blue,
                                                                                       ),
                                                                                       Text("4/5",
                                                                                         style: TextStyle(color: Colors.black),
                                                                                       ),
                                                                                     ],
                                                                                   ),
                                                                                 )),
                                                                           ],
                                                                         ),
                                                                       );
                                                                     }
                                                                 ));
                                                               },
                                                               icon: Icon(
                                                               Icons.remove_red_eye_sharp,
                                                               color: Colors.white70,
                                                             ),),
                                                             IconButton(onPressed: ()=>{}, icon: Icon(
                                                               Icons.share,
                                                               color: Colors.white70,
                                                             )),
                                                             IconButton(onPressed: ()=>{}, icon: Icon(
                                                               Icons.file_download,
                                                               color: Colors.white70,
                                                             )),
                                                           ],
                                                         ),
                                                         decoration: new BoxDecoration(
                                                             color: Colors.black26,
                                                             borderRadius: BorderRadius.all(
                                                                 Radius.circular(10))),
                                                       ),
                                                     )
                                                ),
                                   /*             Positioned(
                                                  top: 180,
                                                  left: 20,
                                                  child:Container(
                                                    decoration: new BoxDecoration(
                                                        color: Colors.black26,
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(12))),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons.remove_red_eye_sharp,
                                                          color: Colors.blue,
                                                        ),
                                                        Text("20",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width: 80,
                                                        ),
                                                        Icon(
                                                          Icons.stars_rounded,
                                                          color: Colors.blue,
                                                        ),
                                                        Text("4/5",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ),*/
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
              Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      scrollDirection: Axis.vertical,
                      initialPage: 2,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      autoPlay: false,
                    ),
                    items: imageSliders,
                  )),

              Container(
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
                    items: imageSliders),
                  )
              /*Obx(() {
                if (_controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return;
              })*/
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