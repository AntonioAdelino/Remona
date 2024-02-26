import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends GetxController {
  late SharedPreferences _sharedPreferences;
  RxMap<String, String> host = RxMap();

  HomeViewModel() {
    _startStoreController();
  }

  _startStoreController() async {
    await _startSharedPreferences();
    _readHost();
  }

  Future<void> _startSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void _readHost() {
    final name = _sharedPreferences.getString('name') ?? '';
    final url = _sharedPreferences.getString('url') ?? '';
    host['name'] = name;
    host['url'] = url;
  }

  Future<void> saveHost(String name, String url) async {
    await _sharedPreferences.setString('name', name);
    await _sharedPreferences.setString('url', url);
    _readHost();
  }
}
