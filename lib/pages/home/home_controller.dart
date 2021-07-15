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
  addProduct(prod) async {
    var producBox = await Hive.openBox('product');
    producBox.add(prod);
    print(producBox.get(0));
  }
/*  Future addProductx(int photoId, String categorie, String url) async {
    final product = Product()
      ..photoId = photoId
      ..categorie = categorie
      ..url = url;

    final box = Product.getProd();
    box.add(product);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }*/
  void removeProduct(int id) async{

  }
}