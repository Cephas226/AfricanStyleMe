import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:hive/hive.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:hive_flutter/hive_flutter.dart';

final FavorisController _favController = Get.put(FavorisController());
final snackBar = SnackBar(content: Text('Desépinglé avec succès'));

class FavorisPage extends GetView<FavorisController> {
  double timeDilation = 5.0;
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
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        //height: double.infinity,
                        color: Color(0xFFF70759),
                        child: PhotoHero(

                          photo: product.url,
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
                                            color: Colors.white38,
                                            child: PhotoHero(
                                              photo:  product.url,
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
                                onPressed: () => {},
                                icon: FavoriteButton(
                                    iconSize: 40,
                                    isFavorite: true,
                                    valueChanged: (_isFavorite) {
                                      if (!_isFavorite) {
                                        _favController.removeProduct(index);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    })),
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
