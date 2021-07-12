import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  // animation controller for lottie
  AnimationController animationController;

  // initializing userData instance
 // final userData = GetStorage();

  // store Login status
  bool isLoggedIn;

  // function to set the user saved theme on start
  setTheme() {
  }


  @override
  void onInit() {
    super.onInit();
    // spalsh animation config
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    Timer(
      Duration(milliseconds: 5500),
      () => Get.offNamed(isLoggedIn ? '/home' : '/welcome'),
    );
  }

  @override
  void onReady() async {
    super.onReady();
    await setTheme();
  }

  @override
  void onClose() async {
    animationController.dispose();
    super.onClose();
  }
}
