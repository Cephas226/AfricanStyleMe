import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_controller.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';

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
                            return xCriteria != null ?
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
                                              floatingActionButton: FloatingActionButton(
                                                onPressed: () {
                                                  // Add your onPressed code here!
                                                },
                                                child: const Icon(Icons.file_download),
                                                backgroundColor: Colors.blueAccent,
                                              ),
                                              appBar: AppBar(
                                                backgroundColor: Color(0xFFF70759),
                                                title: const Text('Details'),
                                              ),
                                              body:Stack(
                                                fit:StackFit.passthrough,
                                                children: [
                                                  Container(
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
                                    child:ClipRect(
                                      child:
                                      Container(
                                        width: 200,
                                        height: double.infinity,
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: xCriteria[index]["url"],
                                            fit: BoxFit.fill),
                                      ),
                                    ),
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
            _gestureDetector(context, "categorie", "Enfant","assets/a.jpg")
            /*GestureDetector(
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
                            final data = snapshot.data;

                            if(data != null){
                              homme = data.where((o) => o['categorie'] == "Homme").toList();
                              couple =data.where((o) => o['categorie'] == "Couple").toList();
                              enfant =data.where((o) => o['categorie'] == "Enfant").toList();
                            }
                            return homme != null ?
                            GridView.builder(
                              itemCount:homme.length,
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
                                            floatingActionButton: FloatingActionButton(
                                              onPressed: () {
                                                // Add your onPressed code here!
                                              },
                                              child: const Icon(Icons.file_download),
                                              backgroundColor: Colors.blueAccent,
                                            ),
                                            appBar: AppBar(
                                              backgroundColor: Color(0xFFF70759),
                                              title: const Text('Details'),
                                            ),
                                            body:Stack(
                                              fit:StackFit.passthrough,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(0.0),
                                                  height: double.infinity,
                                                  color: Color(0xFFF70759),
                                                  child: PhotoHero(
                                                    photo:  homme[index]["url"],
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
                                  child:ClipRect(
                                    child:
                                    Container(
                                      width: 200,
                                      height: double.infinity,
                                      child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: homme[index]["url"],
                                          fit: BoxFit.fill),
                                    ),
                                  ),
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
                          image: AssetImage("assets/a.jpg"),
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
                    "Homme",
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
        ),
            GestureDetector(
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
                                    final data = snapshot.data;
                                    if (data!=null){
                                      femme =data.where((o) => o['categorie'] == "Femme").toList();
                                      print(couple);
                                    }
                                    return femme!=null
                                        ? GridView.builder(
                                      itemCount:femme.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context).orientation ==
                                            Orientation.landscape ? 3: 2,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder: (context,index,) {
                                        return GestureDetector(
                                          onTap:(){
                                            // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                          },
                                          child:ClipRect(
                                            child:
                                            Container(
                                              width: 200,
                                              height: double.infinity,
                                              child: FadeInImage.memoryNetwork(
                                                  placeholder: kTransparentImage,
                                                  image: femme[index]["url"],
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
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
              child:
              Stack(
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("assets/b.jpg"),
                              fit: BoxFit.cover)),
                      child: Transform.translate(
                        offset: Offset(50, -50),
                        child: Container(
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
                        "Femme",
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
            ),
            GestureDetector(
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
                                    final data = snapshot.data;
                                    if (data!=null){
                                      couple =data.where((o) => o['categorie'] == "Couple").toList();
                                      print(couple);
                                    }
                                    return couple != null?
                                    GridView.builder(
                                      itemCount:couple.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context).orientation ==
                                            Orientation.landscape ? 3: 2,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder: (context,index,) {
                                        return GestureDetector(
                                          onTap:(){
                                            // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                          },
                                          child:ClipRect(
                                            child:
                                            Container(
                                              width: 200,
                                              height: double.infinity,
                                              child: FadeInImage.memoryNetwork(
                                                  placeholder: kTransparentImage,
                                                  image: couple[index]["url"],
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                        :Center (
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
              child:
              Stack(
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("assets/c.jpg"),
                              fit: BoxFit.cover)),
                      child: Transform.translate(
                        offset: Offset(50, -50),
                        child: Container(
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
                        "Couple",
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
            ),
            GestureDetector(
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
                                    final data = snapshot.data;
                                    return enfant!=null?
                                    GridView.builder(
                                      itemCount:enfant.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context).orientation ==
                                            Orientation.landscape ? 3: 2,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder: (context,index,) {
                                        return GestureDetector(
                                          onTap:(){
                                            // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                          },
                                          child:ClipRect(
                                            child:
                                            Container(
                                              width: 200,
                                              height: double.infinity,
                                              child: FadeInImage.memoryNetwork(
                                                  placeholder: kTransparentImage,
                                                  image: enfant[index]["url"],
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
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
              child:
              Stack(
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("assets/a.jpg"),
                              fit: BoxFit.cover)),
                      child: Transform.translate(
                        offset: Offset(50, -50),
                        child: Container(
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
                        "Enfant",
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
            ),*/
          ],
        ),
      ),
    );
  }
}
