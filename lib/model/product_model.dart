import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product {

  @HiveField(0)
  int productId;

  @HiveField(1)
  String url;

  @HiveField(2)
  int note;

  @HiveField(3)
  String categorie;

  @HiveField(4)
  bool favorite;

  Product({this.productId, this.url, this.note, this.categorie, this.favorite});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    url: json["url"],
    note: json["note"],
    categorie: json["categorie"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "url": url,
    "note": note,
    "categorie": categorie,
    "favorite":favorite
  };
  List<Product> productFromJson(String str) =>
      List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

  String todoToJson(List<Product> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  @override
  String toString() {
    return '{productId: $productId, url: $url,note:$note,categorie:$categorie,favorite:$favorite}';
  }
}
enum productChip { TOUT, RECENT,MIEUX_NOTE, ALEATOIRE }