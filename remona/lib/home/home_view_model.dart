import 'package:get/get.dart';
import 'home_model.dart';

class HomeViewModel extends GetxController {
  Rx<HomeModel> homeModel = HomeModel().obs;

  Future<void> saveHost(String name, String url) async {
    await homeModel.value.save(name, url);
  }
}
