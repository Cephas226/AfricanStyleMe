import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:getx_app/domain/request.dart';
class HomeController extends GetxController {
  final String title = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  RxList<Product> dataProductChip = <Product>[].obs;
  bool favorite= false;
  String productBox = 'product';

  //Gestion des chip

  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;

  var _reactChipx = 0.obs;
  get reactChipx => this._reactChipx.value;
  set reactChipx(index) => this._reactChipx.value = index;
  @override
  void onInit() async {
    super.onInit();
    selectedChip=0;
   // WidgetsFlutterBinding.ensureInitialized();
   // dataProduct(getChipProduct(productChip.values[selectedChip]));
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
        dataProductChip.value=jsonResponse.map((e) => Product.fromJson(e)).toList();
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

  List<dynamic> getChipProduct(productChip chip) {
    print(chip.index);
    switch (chip) {
      case productChip.TOUT:
       return  dataProductChip.value=dataProduct.reversed.toList();

      case productChip.RECENT:
        return  dataProductChip.value = dataProduct.where((o) => o.note >3).toList();

      case productChip.MIEUX_NOTE:
        return dataProductChip.value = dataProduct.where((o) => o.note ==3).toList();

      case productChip.ALEATOIRE:
        return dataProductChip.toList();
    }
  }

}