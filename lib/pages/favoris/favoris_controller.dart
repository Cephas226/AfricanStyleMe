import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavorisController extends GetxController {
  var box;
  String productBoxName = 'product';
  final String title = 'Accueil';
  List<Product> allProduct = [];
 List<Product> productList = [];
  //RxList<Product> productList = <Product>[].obs;

  Box<Product> productBox;
  @override
  void onInit() async{
   // await Hive.openBox(productBox);
    super.onInit();
    getFavProduct();
    productBox = Hive.box<Product>(productBoxName);
  }
  Future<List<Product>> getFavProduct() async {
    //box= await Hive.openBox(productBox);
    if (productBox!=null){
      for (int i = 0; i < productBox.length; i++) {
        var prodMap = productBox.getAt(i);
        Product tmp = Product();
        tmp.productId = prodMap.productId;
        tmp.categorie = prodMap.categorie;
        tmp.url = prodMap.url;
        productList.add(tmp);
      }
    }
    productList.forEach((element) {print(element);});
    return productList;
  }
  void removeProduct(int id) async{
    //var producBox = await Hive.openBox(productBox);
    productBox.deleteAt(id);
    print("succes");
  }
}