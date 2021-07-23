import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_controller.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'dart:math' as math;
import 'package:transparent_image/transparent_image.dart';

class CategoriesPage extends GetView<CategoriesController> {
  List homme;
  List femme;
  List couple;
  List enfant;
  final CategoriesController _catController = Get.put(CategoriesController());

  Widget _gestureDetector(BuildContext context,String param1,String param2,String assetUrl){
    return  GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return
                Scaffold(
                    appBar: AppBar(
                      title: const Text('Photo'),
                      backgroundColor: Color(0xFFF70759),
                    ),
                    body:Center(
                      child:
                      FutureBuilder(
                          future: Dataservices.fetchProduct(),
                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            List xCriteria;
                            if (snapshot.hasData){
                              xCriteria=snapshot.data.where((o) => o[param1] == param2).toList();
                            }
                            return snapshot.hasData ?
                            GridView.builder(
                              itemCount:xCriteria.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: MediaQuery.of(context).orientation ==
                                    Orientation.landscape ? 3: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context,index,) {
                                return
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                            return Scaffold(

                                              floatingActionButton: buildSpeedDial(),
                                              appBar: AppBar(
                                                backgroundColor: Color(0xFFF70759),
                                                title: const Text('Details'),
                                              ),
                                              body:Stack(
                                                fit:StackFit.passthrough,
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
                                                        photo:  xCriteria[index]["url"],
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(bottom:65, right:10),
                                                      child:Align(alignment: Alignment.bottomRight,
                                                        child: Container(
                                                          width: 70,
                                                          height: 400,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets.only(bottom:25),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Icon(Icons.favorite, size:35, color: Colors.white),
                                                                    Text('427.9K', style:TextStyle(color: Colors.white))
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(bottom:20),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Transform(alignment:Alignment.center,transform: Matrix4.rotationY(math.pi), child: Icon(Icons.sms, size:35, color:Colors.white)),
                                                                    Text('2051', style:TextStyle(color: Colors.white))
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(bottom:50),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Transform(alignment:Alignment.center,transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, size:35, color:Colors.white)),
                                                                    Text('Partager', style:TextStyle(color: Colors.white))
                                                                  ],
                                                                ),
                                                              ),
                                                              /*AnimatedBuilder(
                      animation: animationController,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0x222222).withOpacity(1),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: AssetImage('assets/oboy.jpg'),
                        ),
                      ),
                      builder: (context, _widget){
                        return Transform.rotate(angle: animationController.value*6.3,
                            child:_widget);
                      },)*/
                                                            ],
                                                          ),
                                                        ),))
                                                ],
                                              ),
                                            );
                                          }
                                      ));
                                    },
                                    child:
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadiusDirectional
                                              .circular(20)),
                                      clipBehavior: Clip.antiAlias,
                                      child: FadeInImage.memoryNetwork(
                                          placeholder:
                                          kTransparentImage,
                                          image: xCriteria[index]["url"],
                                          fit: BoxFit.contain),
                                    )
                                  );
                              },
                            )
                                : Center (
                              child: Text(
                                  "Aucune image"
                              ),
                            );
                          }),
                    )
                );
            }
        ));
      },
      child: Stack(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(assetUrl),
                      fit: BoxFit.cover)),
              child: Transform.translate(
                offset: Offset(50, -50),
                child:
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(
                      horizontal: 65, vertical: 63),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: Text(
                param2,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Catégories",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      body: Container(
        child:
        ListView(
          padding: const EdgeInsets.all(1),
          children: <Widget>[
            _gestureDetector(context, "categorie", "Homme","assets/a.jpg"),
            _gestureDetector(context, "categorie", "Femme","assets/b.jpg"),
            _gestureDetector(context, "categorie", "Couple","assets/c.jpg"),
            _gestureDetector(context, "categorie", "Enfant","assets/d.jpg")
          ],
        ),
      ),
    );
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
          child: IconButton(
              onPressed: () => {},
              icon: FavoriteButton(
                  iconSize: 40,
                  isFavorite: false,
                  valueChanged:
                      (_isFavorite) { })),
          backgroundColor: Colors.blueAccent,
          onTap: () => print('Pressed Write'),
          labelStyle:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.share, color: Colors.white),
          backgroundColor: Colors.blueAccent,
          onTap: () => print('Pressed Code'),
          labelStyle:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  }
}
