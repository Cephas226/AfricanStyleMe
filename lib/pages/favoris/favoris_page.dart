import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:hive/hive.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:hive_flutter/hive_flutter.dart';

final FavorisController _favController = Get.put(FavorisController());
final snackBar = SnackBar(content: Text('Desépinglé avec succès'));
class FavorisPage extends GetView<FavorisController> {
  @override
  Widget build(BuildContext context) {
    //Box settingsBox = Hive.box("product");
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
  return
    FutureBuilder(
      future: _favController.getFavProduct(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        final data = snapshot.data;
        return snapshot.hasData
            ?
              Obx(()=>ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print(index);
                  return GestureDetector(
                      onTap: () => {},
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
                                  photo:  data[index].url,
                                  width: double.infinity,
                                  onTap: () {
                                    Navigator.of(context).pop();
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
                                    /* IconButton(
                                  onPressed:()  =>{
                                    _favController.removeProduct(index),
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar),
                                    _favController.getFavProduct(),
                                  },
                                  icon:  Icon(Icons.push_pin,color: Colors.red,size: 30,))*/

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
              ))
            : Center(
            child:Text(
              "Aucune image"
            )
        );
      });
}
