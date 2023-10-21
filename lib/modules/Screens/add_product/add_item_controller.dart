import 'dart:io';

import 'package:beezar/modules/Screens/add_product/add_item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController {
  AddItemService service = AddItemService();
  var subCatName;
  var subCatID;
  var name;
  var des;
  var price;
  String dropdownvalue = 'حلب';
  var CatID;
  var Done = false.obs;
  List<TextEditingController> textController =
      List.generate(5, (i) => TextEditingController());

  List<File> selectedImages = [];
  final picker = ImagePicker();

  @override
  void onInit() {
    subCatID = Get.arguments[0];
    subCatName = Get.arguments[1];
    CatID = Get.arguments[2];
    super.onInit();
  }

  void deleteImage() {
    selectedImages = [];
    update();
  }

  Future getImages() async {
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

  clear() {
    selectedImages = [];
    update();
  }

  onChange(String? newValue) {
    dropdownvalue = newValue!;
    update();
  }

  Future<bool> AddItem() async {
    Done.value = await service.AddItem(
        name, des, price, dropdownvalue, selectedImages, subCatID, CatID);
    return Done.value;
  }
}
