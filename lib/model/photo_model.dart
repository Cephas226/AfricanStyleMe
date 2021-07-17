import 'dart:convert';

import 'dart:typed_data';

import 'package:hive/hive.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String todoToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.photoId,
    this.url,
    this.categorie,
    this.favorite,
  });

  int photoId;
  String url;
  String categorie;
  bool favorite;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    photoId: json["photoId"],
    url: json["url"],
    categorie: json["categorie"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "photoId": photoId,
    "url": url,
    "categorie": categorie,
    "favorite":favorite
  };
}