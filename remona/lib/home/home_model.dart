import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModel extends GetxController {
  late SharedPreferences _sharedPreferences;
  RxMap<String, String> host = RxMap();

  HomeModel() {
    _initHomeModel();
  }

  _initHomeModel() async {
    await _startSharedPreferences();
    _read();
  }

  Future<void> _startSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void _read() {
    final name = _sharedPreferences.getString('name') ?? '';
    final url = _sharedPreferences.getString('url') ?? '';
    host['name'] = name;
    host['url'] = url;
  }

  Future<void> save(String name, String url) async {
    await _sharedPreferences.setString('name', name);
    await _sharedPreferences.setString('url', url);
    _read();
  }
}
