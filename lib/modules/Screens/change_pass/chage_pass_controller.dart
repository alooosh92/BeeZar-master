import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  List<TextEditingController> textController =
      List.generate(3, (i) => TextEditingController());
}
