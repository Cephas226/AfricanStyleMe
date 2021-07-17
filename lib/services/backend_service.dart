import 'package:getx_app/model/photo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Dataservices {
  List allProduct = [];
  static var client = http.Client();

  /*static Future<List<Product>> getPhoto() async {
    var response =await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/product"));

    if (response.statusCode == 200) {
      var data = response.body;
      return photoFromJson(data);
    } else {
      return null;
    }
  }*/
  static Future<List> fetchProduct() async {
    final response =
    await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/product"));

    if (response.statusCode == 200)
      return json.decode(response.body);
    return [];
  }
}