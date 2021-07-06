import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_controller.dart';

class CategoriesPage extends GetView<CategoriesController> {
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
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Stack(
             children: [
               Card(
                 color: Colors.transparent,
                 elevation: 0,
                 child: Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       image: DecorationImage(
                           image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/2.jpg?alt=media&token=eda824fd-3729-44c9-95b2-588b6967593a"),
                           fit: BoxFit.cover)),
                   child: Transform.translate(
                     offset: Offset(50, -50),
                     child:
                     Container(
                       margin: EdgeInsets.symmetric(
                           horizontal: 65, vertical: 63),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.white),
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
            Stack(
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/10.jpg?alt=media&token=8e4d7611-1707-4fe2-ab72-c0feefe37477"),
                            fit: BoxFit.cover)),
                    child: Transform.translate(
                      offset: Offset(50, -50),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 65, vertical: 63),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
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
            Stack(
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
                            fit: BoxFit.cover)),
                    child: Transform.translate(
                      offset: Offset(50, -50),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 65, vertical: 63),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
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
            Stack(
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/10.jpg?alt=media&token=8e4d7611-1707-4fe2-ab72-c0feefe37477"),
                            fit: BoxFit.cover)),
                    child: Transform.translate(
                      offset: Offset(50, -50),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 65, vertical: 63),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
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
            Stack(
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/6.jpg?alt=media&token=0063b131-fd7d-48a6-9b4b-364c678ef1a4"),
                            fit: BoxFit.cover)),
                    child: Transform.translate(
                      offset: Offset(50, -50),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 65, vertical: 63),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
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
            )
          ],
        ),
      ),
    );
  }
}
