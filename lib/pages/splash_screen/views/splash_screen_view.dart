import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/splash_screen/controllers/splash_screen_controller.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/themes/text_theme.dart';
import 'package:lottie/lottie.dart';
class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Lottie.network(
                  'https://myafricanstyle.herokuapp.com/files/ebf444e6-f0aa-4d23-bad1-03d28ad8f883',
                  controller: _.animationController,
                  frameRate: FrameRate(60),
                  repeat: true,
                  onLoaded: (composition) {
                    _.animationController..duration = composition.duration;
                  },
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Text(
                'Taskly',
                style: kHeadTextStyle.copyWith(
                  color: primaryGrey,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
