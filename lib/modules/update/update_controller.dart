import 'dart:io';
import 'package:beezar/config/server_config.dart';
import 'package:beezar/modules/update/update_item_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateController extends GetxController {
  List<String> listImage = [
    'assets/images/add.png',
    'assets/images/add.png',
    'assets/images/add.png'
  ];
  List<File> selectedImages = [];
  String dropDown = "";

  void updateRegion(String val) {
    dropDown = val;
    update();
  }

  void deleteImage() {
    selectedImages.clear();
    update();
  }

  Future getImages() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      update();
    } else {
      Get.snackbar('رساله', 'انت لم تقم باختيار اي صور',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> updateItem(UpdateItemModel item) async {
    final sp = await SharedPreferences.getInstance();
    http.MultipartRequest request = http.MultipartRequest(
        "post", Uri.parse("${ServerConfig.DNS}/api/update_item/${item.id}"));
    request.headers.addAll({
      'Authorization': 'Bearer ${sp.getString('id')}',
    });
    request.fields["name"] = item.name;
    request.fields["description"] = item.description;
    request.fields["category_id"] = item.categoryId.toString();
    request.fields["sub_category_id"] = item.subCategoryId.toString();
    request.fields["price"] = item.price.toString();
    List<http.MultipartFile> files = [];
    for (File file in selectedImages) {
      var f = await http.MultipartFile.fromPath('images[]', file.path);
      files.add(f);
    }
    request.files.addAll(files);
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
