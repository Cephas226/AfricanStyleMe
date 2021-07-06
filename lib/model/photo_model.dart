import 'dart:convert';

List<Photo> todoFromJson(String str) =>
    List<Photo>.from(json.decode(str).map((x) => Photo.fromJson(x)));

String todoToJson(List<Photo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Photo {
  Photo({
    this.photoId,
    this.photoCode,
    this.completed,
  });

  int photoId;
  String photoCode;
  bool completed;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    photoId: json["photoId"],
    photoCode: json["photoCode"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "photoId": photoId,
    "photoCode": photoCode,
    "completed": completed,
  };
}