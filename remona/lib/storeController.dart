import 'package:shared_preferences/shared_preferences.dart';

class StoreController {
  late SharedPreferences _sharedPreferences;
  Map<String, String> hosts = {
    'name': 'google',
    'url': 'www.google.com',
  };

  StoreController() {
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
    hosts = {
      'name': name,
      'url': url,
    };
  }

  Future<void> saveHost(String name, String url) async {
    await _sharedPreferences.setString('name', name);
    await _sharedPreferences.setString('url', url);
    _readHost();
  }
}
