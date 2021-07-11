import 'dart:convert';

import 'dart:typed_data';

List<Photo> photoFromJson(String str) =>
    List<Photo>.from(json.decode(str).map((x) => Photo.fromJson(x)));

String todoToJson(List<Photo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photo {
  Photo({
    this.photoId,
    this.url,
    this.categories,
  });

  int photoId;
  String url;
  bool categories;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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