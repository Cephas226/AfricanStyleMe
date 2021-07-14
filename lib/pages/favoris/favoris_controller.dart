import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:hive/hive.dart';

class FavorisController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Product>().obs;
  var current = 0.obs;
  String productBox = 'product';
  final String title = 'Accueil';
  List<Product> allProduct = [];
  @override
  void onInit() async{
    fetchfinalphoto();
    getFavProduct();
    allProduct = await getFavProduct();
    super.onInit();
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
    var box = await Hive.openBox(productBox);
    List<Product> productList = [];
    for (int i = 0; i < box.length; i++) {
      var prodMap = box.getAt(i).map((k, e) => MapEntry(k.toString(), e));
      Product tmp = Product();
      tmp.photoId = prodMap['photoId'];
      tmp.categories = prodMap['categories'];
      tmp.url = prodMap['url'];
      productList.add(tmp);
      print("cooly");
    }
    return productList;
  }
}
