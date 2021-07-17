import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:hive_flutter/hive_flutter.dart';

final FavorisController _favController = Get.put(FavorisController());
class FavorisPage extends GetView<FavorisController> {
  @override
  Widget build(BuildContext context) {
   Box settingsBox = Hive.box("product");
    return Scaffold(
      body: _builListView(),
    );
        /*    ListView(
          children: _controller.photoList.map((e) =>
    GestureDetector(
      onTap: (){
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
                        photo:  e.url,
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
      child:  Container(
        height: 600,
        width: double.infinity,
        child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: e.url,
            fit: BoxFit.fill),
      ),
    )).toList(),
        ),*/

  }
}

Widget _builListView() {
  return FutureBuilder(
      future: _favController.getFavProduct(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        final data = snapshot.data;
        return snapshot.hasData
            ?ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => {},
                      child: ClipRRect(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 600,
                              width: double.infinity,
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: data[index].url,
                                  fit: BoxFit.fill),
                            ),
                            Positioned(
                              right: 80,
                              bottom: 550,
                              child: Container(
                                child: Row(
                                  children: [
                                 IconButton(
                                    onPressed:()  =>{
                                      _favController.removeProduct(index),
                              }
                                   /* onPressed:() async =>{
                                  _favController.removeProduct(index),
                                  _timer?.cancel();
                                  await EasyLoading.show(
                                  status: 'loading...',
                                  maskType: EasyLoadingMaskType.black,
                                  );
                                  print('EasyLoading show');
                                 _favController.getFavProduct(),
                                 }*/, icon:  Icon(Icons.push_pin,color: Colors.red,size: 30,))

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
              )
            : Center(
            child:
            new CircularProgressIndicator());
      });
/*    ListView.builder(
    itemCount: _favController.allProduct.length,
    itemBuilder: (context, index) {
      final prod = _favController.allProduct[index];
      print(prod.toJson());
      return GestureDetector(
        onTap: ()=>{},
        child:  Container(
          height: 600,
          width: double.infinity,
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: prod.url,
              fit: BoxFit.fill),
        ),
      );
    },
  );*/
}

Widget _buildListView() {

/*    ValueListenableBuilder(
    valueListenable: Hive.box<Product>('product').listenable(),
    builder: (context, Box<Product> box, _) {
      if (box.values.isEmpty) {
        return Text('data is empty');
      } else {
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            var prod = box.getAt(index);
            return ListTile(
              title: Text(prod.categorie),
            );
          },
        );
      }
    },
  );*/
}