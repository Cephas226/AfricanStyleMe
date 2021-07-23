import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:getx_app/domain/request.dart';
class HomeController extends GetxController {
  String titlex = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  RxList<Product> dataProductChip = <Product>[].obs;
  bool favorite= false;
  String productBoxName = 'product';
  //Gestion des chip

  List _inventoryList = <Product>[];

  List get inventoryList => _inventoryList;

  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;

  //Box
  Box<Product> productBox;

  @override
  void onInit() async {
    super.onInit();
    selectedChip=0;
    readProduct();
    //await Hive.openBox<Product>(productBoxName);

    productBox = Hive.box<Product>(productBoxName);
    //
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
        dataProductChip.value=dataProduct.reversed.toList();
        print("Loaded");
      }else{
        print('Backend error');
      }
    }).catchError((onError) {
      printError();
    });
  }
  addProduct(Product prod,context) async {
    productBox.add(prod);
    //print(productBox);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enregistré dans favoris')));
  }
  void removeProduct(int id) async{
    //var producBox = await Hive.openBox(productBox);
    productBox.deleteAt(id);
    print("succes");
  }
  favToggleRepeat(bool newValue) {
    favorite = newValue;
    update(['favorite', true]);
  }

  List<dynamic> getChipProduct(productChip chip) {
    switch (chip) {
      case productChip.TOUT:
       return  dataProductChip.value=dataProduct.reversed.toList();

      case productChip.RECENT:
        return  dataProductChip.value = dataProduct;

      case productChip.MIEUX_NOTE:
        return dataProductChip.value = dataProduct.where((o) => o.note >3).toList();

      case productChip.ALEATOIRE:
        return dataProductChip.toList();
    }
  }

}