import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_page.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/pages/favoris/favoris_page.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/themes/text_theme.dart';
import '../../main.dart';
import 'splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return
            new Scaffold(
              body: Stack(
                children: [
                  new Image.asset(
                    "assets/pagne81.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                      bottom: 90.0,
                      right: 20.0,
                      left: 0.0,
                      child: Container(
                        width: 200,
                        decoration: new BoxDecoration(
                            color: Colors.black12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               Text("Chic Mode", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800))
                          ],
                        ),
                      )),
                ],
              ),
            );
        }),
      ),
    );
  }
}
