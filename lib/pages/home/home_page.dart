import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/videos/video_page.dart';
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

  List<String> imageList = [];
  @override
  Widget build(BuildContext context) {
   // final snackBar = SnackBar(content: Text('Image sauvegardée avec succès'));
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
                          future: Dataservices.fetchProduct(),
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
                                                        return _details(context,item);
                                                      }
                                                  ));
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusDirectional.circular(20)),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: FadeInImage.memoryNetwork(
                                                      placeholder: kTransparentImage,
                                                      image: item["url"],
                                                      fit: BoxFit.contain),
                                                ),
                                                /*Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).buttonColor,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child:
                                                  FadeInImage.memoryNetwork(
                                                      placeholder: kTransparentImage,
                                                      image: item["url"],
                                                      fit: BoxFit.cover),
                                                ),*/
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
                                                                    return
                                                                      _details(context,item);
                                                                  }
                                                              ));
                                                            },
                                                            icon: Icon(
                                                              Icons.remove_red_eye_sharp,
                                                              color: Colors.white70,
                                                            ),),
                                                          IconButton(
                                                              onPressed: ()=>{},
                                                              icon: FavoriteButton(
                                                                iconSize: 40,
                                                                isFavorite: false,
                                                                valueChanged: (_isFavorite) {
                                                                  if (_isFavorite){
                                                                     _prodController.addProduct(item,context);}
                                                                  }
                                                              )),
                                                          IconButton(onPressed: () async =>{
                                                            _saveImage(item["url"],item["productId"],context),
                                                          }, icon: Icon(Icons.file_download, color: Colors.white70,
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
              Center(
                child: FutureBuilder(
                    future: Dataservices.fetchProduct(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      final data = snapshot.data;
                      return snapshot.hasData ?
                      CarouselSlider.builder(
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
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            ClipRRect(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 600,
                                    width: double.infinity,
                                    child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: data[itemIndex]["url"],
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
                            ),
                      )
                          : const CircularProgressIndicator();
                    }),
              ),
              Center(
                child:
                FutureBuilder(
                    future: Dataservices.fetchProduct(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      return snapshot.hasData ?
                      CarouselSlider.builder(
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
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
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
Widget _details(context,item) {
  return
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveImage(item["url"],item["productId"],context);
        },
        child: const Icon(Icons.file_download),
        backgroundColor: Colors.blueAccent,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF70759),
        title: const Text('Details'),
      ),
      body:
      Stack(
        fit:StackFit.passthrough,
        children: [

          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(20)),
            clipBehavior: Clip.antiAlias,
            child:
            Container(
              padding: const EdgeInsets.all(0.0),
              height: double.infinity,
              color: Color(0xFFF70759),
              child: PhotoHero(
                photo:  item["url"],
                width: double.infinity,
                height: double.infinity,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
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
_saveImage(url,name,context) async {
  var client = http.Client();
  var response =  await client.get(Uri.parse(url));
  final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.bodyBytes),
      quality: 60,
      name: "model"+name.toString());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image sauvegardée avec succès')));
  print(result);
}