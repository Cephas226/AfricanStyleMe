import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Product>().obs;
  var urList = List().obs;
  List allProduct = [];
  var current = 0.obs;
  final String title = 'Accueil';

  @override
  void onInit() async {
    super.onInit();
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
   addProduct( prod) async {
     var producBox = await Hive.openBox('product');
     producBox.add(prod);
     print(producBox.get(0));
  }
  void removeItem(int id) {

  }
}
