import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:getx_app/domain/request.dart';
class HomeController extends GetxController {
  static var client = http.Client();
  var isLoading = true.obs;
  var photoList = List<Product>().obs;
  var urList = List().obs;
  var current = 0.obs;
  final String title = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  @override
  void onInit() async {
    super.onInit();
    readProd();
  }
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
    //fetchfinalproduct();
  }
  void readProd() async {
    Request request = Request(url: 'product');
    request.get().then((value) {
      if(value.statusCode==200){
        List jsonResponse = jsonDecode(value.body);
        dataProduct.value = jsonResponse.map((e) => Product.fromJson(e)).toList();
        print(dataProduct.map((e) => e.url));
      }else{
        print('Backend error');
      }
    }).catchError((onError) {
      printError();
    });
  }
  addProduct(prod) async {
    var producBox = await Hive.openBox('product');
    producBox.add(prod);
    print(producBox.get(0));
  }
   /*Future<List<dynamic>> fetchProduct() async {
    final response =
    await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/product"));
    if (response.statusCode == 200)
      productList=json.decode(response.body);
       update();
       productList;
    return [];
  }*/
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
  void fetchfinalproduct() async {
    isLoading(true);
    try {
      var products = await Dataservices.fetchProduct();
      if (products != null) {
        //productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}