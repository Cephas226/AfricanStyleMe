import 'package:getx_app/model/photo_model.dart';
import 'package:http/http.dart' as http;

class Dataservices {
  static var client = http.Client();

  static Future<List<Photo>> getPhoto() async {
    var response =
    await client.get('https://jsonplaceholder.typicode.com/todos');

    if (response.statusCode == 200) {
      var data = response.body;
      return todoFromJson(data);
    } else {
      return null;
    }
  }
}