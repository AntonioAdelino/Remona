import 'dart:convert';
import 'package:get/get.dart';
import 'home_model.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController {
  Rx<HomeModel> homeModel = HomeModel().obs;

  Future<void> saveHost(String name, String url) async {
    await homeModel.value.save(name, url);
  }

  Future<List<String>?> fetchData() async {
    String url = 'http://10.20.30.8:8080/api/files';
    url = '$url/list';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> itemList = responseData['list'];
        List<String> nameList = [];
        for (var item in itemList) {
          nameList.add(item['name']);
          print(item['name'] + '\n');
        }
        return nameList;
      } else {
        print('Failed to load data, status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
