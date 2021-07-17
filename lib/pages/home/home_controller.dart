import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:getx_app/domain/request.dart';
class HomeController extends GetxController {
  final String title = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  @override
  void onInit() async {
    super.onInit();
    readProduct();
  }
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }
  void readProduct() async {
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
  void removeProduct(int id) async{

  }
}