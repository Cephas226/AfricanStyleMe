import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String todoToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.productId,
    this.url,
    this.note,
    this.categorie,
    this.favorite,
  });

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