import 'package:beezar/models/category_model.dart';
import 'package:beezar/models/subCategory_model.dart';
import 'package:beezar/modules/Screens/choose_subcategory/sub_category_service.dart';
import 'package:beezar/modules/Screens/subCategory/sub_category_service.dart';
import 'package:get/get.dart';

class ImageViewerController extends GetxController {

  var image;
  @override
  void onInit()async{
    super.onInit();
     image=Get.arguments;

  }
  @override
  void onReady() async{

    super.onReady();
  }

}
