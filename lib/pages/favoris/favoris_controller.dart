import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavorisController extends GetxController {
  var box;
  String productBox = 'product';
  final String title = 'Accueil';
  List<Product> allProduct = [];
  List<Product> productList = [];
  @override
  void onInit() async{
    await Hive.openBox(productBox);
    super.onInit();
    getFavProduct();
  }
  Future<List<Product>> getFavProduct() async {
    box= await Hive.openBox(productBox);

    for (int i = 0; i < box.length; i++) {
      var prodMap = box.getAt(i).map((k, e) => MapEntry(k.toString(), e));
      Product tmp = Product();
      tmp.photoId = prodMap['photoId'];
      tmp.categorie = prodMap['categorie'];
      tmp.url = prodMap['url'];
      productList.add(tmp);
    }
    return productList;
  }
  void removeProduct(int id) async{
    var producBox = await Hive.openBox(productBox);
    producBox.deleteAt(id);
    print("succes");
  }
}