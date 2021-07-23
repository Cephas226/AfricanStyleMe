import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/videos/took.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'dart:math' as math;
import 'package:video_player/video_player.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../main.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _prodController = Get.put(HomeController());
  String titlexy = 'Accueil';
  List<String> imageList = [];
  @override
  Widget build(BuildContext context) {
    final List<String> _chipLabel = [
      'Tout',
      'Récent',
      'Mieux noté',
      'Aléatoire'
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black,
              onTap: (index) {
                print(index);
                if (index == 0) {
                  titlexy = "Accueil";
                }
                if (index == 1) {
                  titlexy = "Noter";
                }
                if (index == 2) {
                  titlexy = "Vidéos";
                }
                /*switch (index) {
                  case 0:
                    return  controller.title="Accueil";

                  case 1:
                    return controller.title="Noter";

                  case 2:
                    return controller.title="Vidéos";
                }*/
              },
              tabs: [
                Tab(icon: Icon(Icons.photo_camera)),
                Tab(icon: Icon(Icons.stars)),
                Tab(icon: Icon(Icons.video_library_sharp)),
              ],
            ),
            title: Text(
              titlexy,
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0,
            backgroundColor: Color(0xFFF70759),
          ),
          drawer: MainDrawer(),
          body: TabBarView(
            children: [
              SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Obx(() => Wrap(
                          spacing: 20,
                          children: List<Widget>.generate(4, (int index) {
                            return ChoiceChip(
                              label: Text(_chipLabel[index]),
                              selected: _prodController.selectedChip == index,
                              onSelected: (bool selected) {
                                _prodController.selectedChip =
                                    selected ? index : null;
                                _prodController.getChipProduct(productChip
                                    .values[_prodController.selectedChip]);
                              },
                            );
                          }))),
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:_detailx(context,_prodController),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: FutureBuilder(
                    future: Dataservices.fetchProduct(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      final data = snapshot.data;
                      return snapshot.hasData
                          ? CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              options: CarouselOptions(
                                height: 800,
                                scrollDirection: Axis.vertical,
                                initialPage: 0,
                                viewportFraction: 1,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll: false,
                                autoPlay: false,
                              ),
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Stack(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      padding: const EdgeInsets.all(0.0),
                                      height: double.infinity,
                                      color: Color(0xFFF70759),
                                      child: PhotoHero(
                                        photo: data.reversed.toList()[itemIndex]
                                            ["url"],
                                        width: double.infinity,
                                        height: double.infinity,
                                        onTap: () {
                                          print("cooly");
                                        },
                                      ),
                                    ),
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
                                            onRatingUpdate: (rating) {},
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
                            )
                          : const CircularProgressIndicator();
                    }),
              ),
              Center(
                child: TokPage(),
              ),
            ],
          )),
    );
  }
}

Widget _details(context,item,meIndex) {
  return Scaffold(
    floatingActionButton: buildSpeedDial(),
    appBar: AppBar(
      backgroundColor: Color(0xFFF70759),
      title: const Text('Detail'),
    ),
    body: FutureBuilder(
        future: Dataservices.fetchProduct(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          final data = snapshot.data;
          return snapshot.hasData
              ?
          CarouselSlider.builder(
                  itemCount: snapshot.data.length,
                  options: CarouselOptions(
                    height: 800,
                    scrollDirection: Axis.vertical,
                    initialPage: meIndex,
                    viewportFraction: 1,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Stack(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: const EdgeInsets.all(0.0),
                          height: double.infinity,
                          color: Color(0xFFF70759),
                          child: PhotoHero(
                            photo: data.reversed.toList()[itemIndex]["url"],
                            width: double.infinity,
                            height: double.infinity,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 65, right: 10),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 70,
                                height: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.favorite,
                                              size: 35, color: Colors.white),
                                          Text('427.9K',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: Icon(Icons.sms,
                                                  size: 35,
                                                  color: Colors.white)),
                                          Text('2051',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: Icon(Icons.reply,
                                                  size: 35,
                                                  color: Colors.white)),
                                          Text('Partager',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                )
              : Center(
            child: CircularProgressIndicator(),
          );
        }),
  );
}


Widget _detailx(context,controller) {
  return Scaffold(
    body: FutureBuilder(
        future: Dataservices.fetchProduct(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          final data = snapshot.data;
          return snapshot.hasData
              ?
          StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            padding: const EdgeInsets.all(2.0),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(12))),
                  child:
                  ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        clipBehavior: Clip.none, fit: StackFit.passthrough,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext
                                      context) {
                                        return _details(context, data.reversed.toList(),index);
                                      }));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional
                                      .circular(20)),
                              clipBehavior: Clip.antiAlias,
                              child: FadeInImage.memoryNetwork(
                                  placeholder:
                                  kTransparentImage,
                                  image: data.reversed.toList()[index]["url"],
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                              left: 130,
                              top: 0,
                              child: Center(
                                child: Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute<
                                                  void>(
                                                  builder:
                                                      (BuildContext
                                                  context) {
                                                    return _details(context, data,index);
                                                  }));
                                        },
                                        icon: Icon(
                                          Icons
                                              .remove_red_eye_sharp,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () => {},
                                          icon: FavoriteButton(
                                              iconSize: 40,
                                              isFavorite: false,
                                              valueChanged:
                                                  (_isFavorite) {
                                                if (_isFavorite) {
                                                  controller.addProduct(
                                                      data,
                                                      context);
                                                }
                                              })),
                                      IconButton(
                                          onPressed: () async =>
                                          {
                                            _saveImage(
                                                data[index]["url"],
                                                data[index]["productId"],
                                                context),
                                          },
                                          icon: Icon(
                                            Icons.file_download,
                                            color:
                                            Colors.white70,
                                          )),
                                    ],
                                  ),
                                  decoration: new BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              10))),
                                ),
                              )),
                        ],
                      )),
                ),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(2),
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 4.0, //
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        }),
  );
}






_saveImage(url, name, context) async {
  var client = http.Client();
  var response = await client.get(Uri.parse(url));
  final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.bodyBytes),
      quality: 60,
      name: "model" + name.toString());
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Image sauvegardée avec succès')));
}

SpeedDial buildSpeedDial() {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 28.0),
    backgroundColor: Colors.blue[900],
    visible: true,
    curve: Curves.easeInCubic,
    children: [
      SpeedDialChild(
        child: Icon(Icons.file_download, color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onTap: () => print('Pressed Read Later'),
        labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
      SpeedDialChild(
        child: Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onTap: () => print('Pressed Write'),
        labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
      SpeedDialChild(
        child: Icon(Icons.share, color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onTap: () async => {},
        labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
    ],
  );
}

/*
Future<List<String>> pickFile() async {
  var client = http.Client();
  var response = await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/files/b879a5c4-ab42-43d7-96f7-b1c38e15630d"));
  Share.shareFiles(response);
  */
/*final result = await FilePicker.platform.pickFiles(allowMultiple: true);
  return result == null ? <String>[] : result.paths;*/ /*

}*/
