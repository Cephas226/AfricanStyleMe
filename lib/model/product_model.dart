import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String todoToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Product {
  Product({
    @HiveField(0)
    this.photoId,
    @HiveField(1)
    this.productId,
    @HiveField(2)
    this.url,
    @HiveField(3)
    this.note,
    @HiveField(4)
    this.categorie,
    @HiveField(5)
    this.favorite,
  });
  int photoId;
  int productId;
  String url;
  int note;
  String categorie;
  bool favorite;

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
}
enum productChip { TOUT, RECENT,MIEUX_NOTE, ALEATOIRE }