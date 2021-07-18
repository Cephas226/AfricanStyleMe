import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:hive/hive.dart';
import 'package:getx_app/domain/request.dart';
class HomeController extends GetxController {
  final String title = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  bool favorite= false;
  String productBox = 'product';
  @override
  void onInit() async {
    super.onInit();
    readProduct();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void readProduct() async {
    Request request = Request(url: 'product');
    request.get().then((value) {
      if(value.statusCode==200){
        List jsonResponse = jsonDecode(value.body);
        dataProduct.value = jsonResponse.map((e) => Product.fromJson(e)).toList();
        print("Loaded");
      }else{
        print('Backend error');
      }
    }).catchError((onError) {
      printError();
    });
  }
  addProduct(prod,context) async {
    var producBox = await Hive.openBox('product').whenComplete(() =>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image favoris avec succès'))));
    producBox.add(prod);
  }
  void removeProduct(int id) async{
    var producBox = await Hive.openBox(productBox);
    producBox.deleteAt(id);
    print("succes");
  }
  favToggleRepeat(bool newValue) {
    favorite = newValue;
    update(['favorite', true]);
  }
}