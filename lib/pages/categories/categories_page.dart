import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_controller.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/orientation/portrait_player_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoriesPage extends GetView<CategoriesController> {
  List homme;
  List femme;
  List couple;
  List enfant;
  final CategoriesController _catController = Get.put(CategoriesController());
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
                                    // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
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
            ),
          ],
        ),
      ),
    );
  }
}
