import 'package:get/get.dart';
import 'package:getx_app/model/photo_model.dart';
import 'package:getx_app/services/backend_service.dart';

class HomeController extends GetxController {
  final String title = 'Accueil';
  var isLoading = true.obs;
  var photoList = List<Photo>().obs;

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
  @override
  void onInit() {
    fetchfinalphoto();
    super.onInit();
  }
}
