import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'dart:math' as math;

final FavorisController _favController = Get.put(FavorisController());
final snackBar = SnackBar(content: Text('Desépinglé avec succès'));
class FavorisPage extends GetView<FavorisController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoris",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _builListView(),
    );
  }
}

Widget _builListView() {
  return ValueListenableBuilder(
    valueListenable: _favController.valueListenable,
    builder: (context, box, _) {
      print(box.values);
      if (box.values.length == 0)
        return Center(
          child: Text("Aucune image"),
        );
      return ListView.builder(
        primary: true,
        padding: EdgeInsets.only(bottom: 95),
        itemCount: box.values.length,
        itemBuilder: (context, int index) {
          Product product = box.getAt(index);
          return GestureDetector(

              child: ClipRRect(
                child: Stack(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      clipBehavior: Clip.antiAlias,
                      child:
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        //height: double.infinity,
                        color: Color(0xFFF70759),
                        child: PhotoHero(
                          photo:  product.url,
                          width: double.infinity,
                          onTap: () {
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
                                              photo: product.url,
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
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 20,
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: ()=>{},
                                icon: FavoriteButton(
                                    iconSize: 40,
                                    isFavorite: true,
                                    valueChanged: (_isFavorite) {
                                      if (!_isFavorite){
                                        _favController.removeProduct(index);
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    }
                                )),
                          ],
                        ),
                        decoration: new BoxDecoration(
                            color: Colors.white10,
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    },
  );
}