import 'package:get/get.dart';
import 'package:getx_app/pages/dashboard/dashboard_binding.dart';
import 'package:getx_app/pages/dashboard/dashboard_page.dart';
import 'package:getx_app/pages/splash_screen/bindings/splash_screen_binding.dart';
import 'package:getx_app/pages/splash_screen/views/splash_screen_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH_SCREEN;
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
