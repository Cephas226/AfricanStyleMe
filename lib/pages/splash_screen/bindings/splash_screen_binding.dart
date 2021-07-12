import 'package:get/get.dart';
import 'package:getx_app/pages/splash_screen/controllers/splash_screen_controller.dart';



class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
  }
}
