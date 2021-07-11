import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/user_modelx.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:getx_app/widget/photohero.dart';
import 'package:getx_app/widget/user.dart';
import 'package:transparent_image/transparent_image.dart';


class FavorisPage extends GetView<FavorisController> {
  final List<UserModel> _userlist = [
    UserModel(1, "Anthony",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18"),
    UserModel(2, "Lea Agustine",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a"),
    UserModel(3, "Mickey",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/1.jpg?alt=media&token=9ce0fbc2-e8df-4565-894c-d24a2f5fbb18"),
    UserModel(4, "Donald Newman",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/8.jpg?alt=media&token=adc21471-2539-4a66-aa9d-bd4c769d839d"),
    UserModel(5, "Pedro Andrado",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
    UserModel(6, "Tony Stark",
        "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
  ];
  @override
  Widget build(BuildContext context) {
    final FavorisController _controller = Get.put(FavorisController());
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "Favoris",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
        body: ListView(
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
        ),
    );
  }
}
