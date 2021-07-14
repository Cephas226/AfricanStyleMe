import 'dart:convert';

import 'dart:typed_data';

List<Product> photoFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String todoToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.photoId,
    this.url,
    this.categories,
  });

  int photoId;
  String url;
  bool categories;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    photoId: json["photoId"],
    url: json["url"],
    categories: json["categories"],
  );

  Map<String, dynamic> toJson() => {
    "photoId": photoId,
    "url": url,
    "categories": categories,
  };
}