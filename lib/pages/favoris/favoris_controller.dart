import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavorisController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Product>().obs;
  var current = 0.obs;
  var box;
  String productBox = 'product';
  final String title = 'Accueil';
  List<Product> allProduct = [];
  @override
  void onInit() async{
   // allProduct = await getFavProduct();
    //await Hive.initFlutter();
    await Hive.openBox("product");
   // await Hive.openBox('product');
    super.onInit();
    fetchfinalphoto();
    getFavProduct();
  }

  void fetchfinalphoto() async {
    isLoading(true);
    try {
      var photos = await Dataservices.getPhoto();
      if (photos != null) {
        photoList.value = photos;
      }
    } finally {
      isLoading(false);
    }
  }
  Future<List<Product>> getFavProduct() async {
     box= await Hive.openBox(productBox);
    List<Product> productList = [];
    for (int i = 0; i < box.length; i++) {
      var prodMap = box.getAt(i).map((k, e) => MapEntry(k.toString(), e));
      Product tmp = Product();
      tmp.photoId = prodMap['photoId'];
      tmp.categorie = prodMap['categorie'];
      tmp.url = prodMap['url'];
      productList.add(tmp);
      print("cooly");
    }
    return productList;
  }
  void removeProduct(int id) async{
    var producBox = await Hive.openBox('product');
    producBox.deleteAt(id);
    print("succes");
  }
}