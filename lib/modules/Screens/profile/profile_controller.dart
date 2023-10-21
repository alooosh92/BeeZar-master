// ignore_for_file: camel_case_types
import 'dart:io';
import 'package:beezar/modules/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/server_config.dart';
import '../../../main.dart';
import '../../../models/profile_user.dart';

class profile_controller extends GetxController {
  UserController userController = Get.find();
  UserModel userModel = UserModel();
  File? image;
  File? empty;
  List<TextEditingController> textController =
      List.generate(5, (i) => TextEditingController());
  ProfileUser? user;
  var url = Uri.parse(ServerConfig.DNS + ServerConfig.updateUser);
  // Initial Selected Value
  String dropdownvalue = sharedPrefs!.getString("address").toString();

  // List of items in our dropdown menu
  var items = [
    'الرقة',
    'الطبقة',
    'الجرنية',
    'منبج',
    'جرابلس',
    'عين عيسى',
    'عزاز',
    'عفرين',
    'ادلب',
    'الباب',
    'الدانا',
    'سرمدا',
    'مارع',
    'جنديرس',
    'حارم',
    'القامشلي',
    'عامودا',
    'معبدة',
    'الحسكة',
    'هجين',
    'بوكمال',
    'الميادين',
    'دير الزور',
    'حلب',
    'ريف حلب',
    'حمص',
    'حماة',
    'دمشق',
    'ريف دمشق',
    'تدمر',
    'طرطوس',
    'اللاذقية',
    'القنيطرة',
    'درعا',
  ];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      userModel.file = imageTemp;
      // user = ProfileUser(
      //     image: this.image,
      //     id: sharedPrefs!.getString('id'),
      //     address: dropdownvalue != 'حلب'
      //         ? dropdownvalue
      //         : sharedPrefs!.getString('address'),
      //     email: sharedPrefs!.getString('email'),
      //     name: sharedPrefs!.getString('name'),
      //     password: textController[4].text,
      //     phone: textController[0].text.isNotEmpty
      //         ? textController[0].text
      //         : sharedPrefs!.getString('phone'),
      //     token: sharedPrefs!.getString('token'));
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  onChange(String? newValue) {
    dropdownvalue = newValue!;
    userModel.address = newValue;
    // user = ProfileUser(
    //     image: image ?? File("assets/images/person.png"),
    //     id: sharedPrefs!.getString('id'),
    //     address: dropdownvalue != 'حلب'
    //         ? dropdownvalue
    //         : sharedPrefs!.getString('address'),
    //     email: sharedPrefs!.getString('email'),
    //     name: sharedPrefs!.getString('name'),
    //     password: textController[4].text,
    //     phone: textController[0].text.isNotEmpty
    //         ? textController[0].text
    //         : sharedPrefs!.getString('phone'),
    //     token: sharedPrefs!.getString('token'));
    update();
  }

  // @override
  // void onInit() {
  //   user = ProfileUser(
  //       image: image ?? File("assets/images/person.png"),
  //       id: sharedPrefs!.getString('id'),
  //       address: sharedPrefs!.getString('address'),
  //       email: sharedPrefs!.getString('email'),
  //       name: sharedPrefs!.getString('name'),
  //       password: sharedPrefs!.getString('password'),
  //       phone: sharedPrefs!.getString('phone'),
  //       token: sharedPrefs!.getString('token'));
  //   super.onInit();
  // }

  changePhone(String phoneNumber) {
    userModel.phone = phoneNumber;
    // user = ProfileUser(
    //     image: image ?? File("assets/images/person.png"),
    //     id: sharedPrefs!.getString('id'),
    //     address: textController[1].text.isNotEmpty
    //         ? textController[1].text
    //         : sharedPrefs!.getString('address'),
    //     email: sharedPrefs!.getString('email'),
    //     name: sharedPrefs!.getString('name'),
    //     password: sharedPrefs!.getString('password'),
    //     phone: textController[0].text,
    //     token: sharedPrefs!.getString('token'));
    update();
    Get.back();
  }

  // changeAddress() {
  //   user = ProfileUser(
  //       image: image ?? File("assets/images/person.png"),
  //       id: sharedPrefs!.getString('id'),
  //       address: textController[1].text,
  //       email: sharedPrefs!.getString('email'),
  //       name: sharedPrefs!.getString('name'),
  //       password: sharedPrefs!.getString('password'),
  //       phone: textController[0].text.isNotEmpty
  //           ? textController[0].text
  //           : sharedPrefs!.getString('phone'),
  //       token: sharedPrefs!.getString('token'));
  //   update();
  //   Get.back();
  // }

  changePassword() {
    if (textController[2].text == sharedPrefs!.getString('password') &&
        textController[3].text == textController[4].text) {
      userModel.password = textController[3].text;
      // user = ProfileUser(
      //     image: image ?? File("assets/images/person.png"),
      //     id: sharedPrefs!.getString('id'),
      //     address: textController[1].text.isNotEmpty
      //         ? textController[1].text
      //         : sharedPrefs!.getString('address'),
      //     email: sharedPrefs!.getString('email'),
      //     name: sharedPrefs!.getString('name'),
      //     password: textController[4].text,
      //     phone: textController[0].text.isNotEmpty
      //         ? textController[0].text
      //         : sharedPrefs!.getString('phone'),
      //     token: sharedPrefs!.getString('token'));
      update();
      Get.back();
    } else {
      Get.snackbar('خطأ', "من فضلك التأكد من ادخال صحيح ");
    }
  }

  Future saveChanges() async {
    var b = await userController.updateUser(userModel);
    if (b) {
      Get.snackbar('رساله', 'تم تغير جميع البيانات بنجاح',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('خطا', ' يوجد مشكله برجاء اعاده المحاوله',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
