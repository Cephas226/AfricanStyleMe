import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/videos/video_page.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../main.dart';
import 'home_controller.dart';
import 'package:share/share.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _prodController = Get.put(HomeController());

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
                              selected:_prodController.selectedChip == index,
                              onSelected: (bool selected) {
                                _prodController.selectedChip =
                                selected ? index : null;
                                _prodController.getChipProduct(productChip.values[_prodController.selectedChip]);
                              },
                            );
                          }))),
                      Obx(() => Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: new StaggeredGridView.count(
                              crossAxisCount: 4,
                              padding: const EdgeInsets.all(2.0),
                              children: _prodController.dataProductChip
                                  .map<Widget>((item) {
                                return new
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                      child: Stack(
                                        fit: StackFit.passthrough,
                                        overflow: Overflow.visible,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                      context) {
                                                        return _details(context, item);
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
                                                  image: item.url,
                                                  fit: BoxFit.contain),
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
                                                                    return _details(
                                                                        context, item);
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
                                                                  _prodController.addProduct(
                                                                      item,
                                                                      context);
                                                                }
                                                              })),
                                                      IconButton(
                                                          onPressed: () async =>
                                                          {
                                                            _saveImage(
                                                                item.url,
                                                                item.productId,
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
                                );
                              }).toList(),
                              staggeredTiles: _prodController.dataProductChip
                                  .map<StaggeredTile>(
                                      (_) => StaggeredTile.fit(2))
                                  .toList(),
                              mainAxisSpacing: 3.0,
                              crossAxisSpacing: 4.0, // add some space
                            ),
                          ),
                        ),
                      ),
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
                                initialPage: 2,
                                viewportFraction: 1,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll: true,
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
                                            photo: data[itemIndex]["url"],
                                            width: double.infinity,
                                            height: double.infinity,
                                            onTap: () {
                                              print("cooly");
                                            },
                                          ),
                                        ),
                                      ),
                                      /*Container(
                                        height: 600,
                                        width: double.infinity,
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: data[itemIndex]["url"],
                                            fit: BoxFit.fill),
                                      ),*/
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
                            )
                          : const CircularProgressIndicator();
                    }),
              ),
              Center(
                child: FutureBuilder(
                    future: Dataservices.fetchProduct(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      return snapshot.hasData
                          ? CarouselSlider.builder(
                              itemCount: snapshot.data.length,
                              options: CarouselOptions(
                                height: 800,
                                scrollDirection: Axis.vertical,
                                initialPage: 2,
                                viewportFraction: 1,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll: true,
                                autoPlay: false,
                              ),
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  ClipRRect(
                                child: Stack(
                                  children: <Widget>[
                                    VideosPage(),
                                  ],
                                ),
                              ),
                            )
                          : const CircularProgressIndicator();
                    }),
              ),
            ],
          )),
    );
  }
}

Widget _details(context, Product item) {
  return Scaffold(
    floatingActionButton: buildSpeedDial(),
    appBar: AppBar(
      backgroundColor: Color(0xFFF70759),
      title: const Text('Details'),
    ),
    body: Stack(
      fit: StackFit.passthrough,
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: const EdgeInsets.all(0.0),
            height: double.infinity,
            color: Color(0xFFF70759),
            child: PhotoHero(
              photo: item.url,
              width: double.infinity,
              height: double.infinity,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Positioned(
            bottom: 90.0,
            right: 0.0,
            left: 0.0,
            child: Container(
              width: 200,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.blue,
                  ),
                  Text(
                    "20",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Icon(
                    Icons.stars_rounded,
                    color: Colors.blue,
                  ),
                  Text(
                    "4/5",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )),
      ],
    ),
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
  print(result);
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
        labelStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
      SpeedDialChild(
        child: Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onTap: () => print('Pressed Write'),
        labelStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
      SpeedDialChild(
        child: Icon(Icons.share, color: Colors.white),
        backgroundColor: Colors.blueAccent,
        onTap: () => Share.share('https://myafricanstyle.herokuapp.com/files/53b7cd56-ae18-4277-ab94-6a929b63f739', subject: 'Look what I made!'),
        labelStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        labelBackgroundColor: Colors.black,
      ),
    ],
  );
}

_onShareData(BuildContext context,url) async {

  final RenderBox box = context.findRenderObject();

  if (url.isNotEmpty) {
    await Share.shareFiles(url,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  } else {
    await Share.share(url,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}