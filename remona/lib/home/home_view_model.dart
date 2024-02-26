import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:path/path.dart';

class HomeViewModel extends GetxController {
  RxString word = 'teste'.obs;
// /Users/antonioneto/AntonioPessoal/PhotoLetter/photoletter/lib/assets/data.json
// /Users/antonioneto/AntonioPessoal/PhotoLetter/photoletter/lib/home/home_view_model.dart
  Future<void> getNewWord() async {
    

    String jsonContent = File('../../lib/assets/data.json').readAsStringSync();
    Map<String, dynamic> data = jsonDecode(jsonContent);
    List<String> words = List<String>.from(data['words']);

    final random = Random();
    word.value = words[random.nextInt(words.length)];
  }
}
