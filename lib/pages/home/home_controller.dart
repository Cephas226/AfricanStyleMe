import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Photo>().obs;
  var current = 0.obs;
  final String title = 'Accueil';
  @override
  void onInit() {
    fetchfinalphoto();
    super.onInit();
  }

  void fetchfinalphoto() async {
    isLoading(true);
    try {
      var photos = await Dataservices.getPhoto();
      if (photos != null) {
        photoList.value = photos;
      }
    } finally {
      isLoading(false);
    }
  }
}
