import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
