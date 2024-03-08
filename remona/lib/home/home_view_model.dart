import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'home_model.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  Future<void> _requestPermission(Permission permission) async {
    PermissionStatus result = await permission.request();
    if (result.isGranted) {
      // Permissão concedida, você pode acessar a galeria de mídia aqui
    }
  }

  Future<void> _checkPermission() async {
    PermissionStatus storage = await Permission.storage.status;
    PermissionStatus photos = await Permission.photos.status;
    PermissionStatus videos = await Permission.videos.status;
    if (!storage.isGranted) {
      // openAppSettings();
      _requestPermission(Permission.storage);
    }
    if (!photos.isGranted) {
      _requestPermission(Permission.photos);
    }
    if (!videos.isGranted) {
      _requestPermission(Permission.videos);
    }
  }

  Future<List<String>> getGalery() async {
    await _checkPermission();
    List<Album> images =
        await PhotoGallery.listAlbums(mediumType: MediumType.image);
    List<Album> videos =
        await PhotoGallery.listAlbums(mediumType: MediumType.video);

    List<Album> gallery = images + videos;
    List<String> galleryPaths = [];
    for (var album in gallery) {
      MediaPage listMedia = await album.listMedia();
      for (var item in listMedia.items) {
        File it = await item.getFile();
        galleryPaths.add(it.path);
        //colocar um loading aqui
        print(it.path);
      }
    }
    return galleryPaths;
  }

  Future<void> uploadGalleryFiles() async {
    // List<String> galleryFiles = await getGalery();
    // List<String> cloudFiles = await fetchData() ?? [];

    // List filesToUpload =
    //     Set.from(galleryFiles).difference(Set.from(cloudFiles)).toList();

    // await uploadToCloud(filesToUpload);

    await uploadToCloud([
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images/IMG-20231102-WA0098.jpg',
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images/IMG-20231014-WA0012.jpg'
    ]);
  }

  Future<void> uploadToCloud(List filesToUpload) async {
    String url = 'http://10.20.30.8:8080';
    String urlCreateFolder = '$url/create-folder';
    String urlLoadFile = '$url/load-file';

    DateTime now = DateTime.now();
    String folderName = now.toString();

    Map<String, String> data = {
      'name': folderName,
      'path': '/files/',
    };
    try {
      // http.Response responseFolder = await http.post(
      //   Uri.parse(urlCreateFolder),
      //   body: jsonEncode(data),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      var request = http.MultipartRequest('POST', Uri.parse(urlCreateFolder));

      request.fields['name'] = folderName;
      request.fields['path'] = '/files/';

      var responseFolder = await request.send();

      if (responseFolder.statusCode == 200) {
        print('Success to create folder!');

        for (String path in filesToUpload) {
          var requestFile =
              http.MultipartRequest('POST', Uri.parse(urlCreateFolder));
          var file = await http.MultipartFile.fromPath('images[]', path);

          requestFile.files.add(file);
          requestFile.fields['path'] = '/files/$folderName';

          var responseFile = await requestFile.send();

          if (responseFile.statusCode == 200) {
            print(path);
          }
        }
      } else {
        // Tratar falha
        print('Falha ao enviar os dados. ');
      }
    } catch (e) {
      // Tratar exceção
      print('Erro ao enviar os dados: $e');
    }

    print("FIMMMMMM");
  }
}
