import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:get/get.dart';

import '../modules/Screens/choose_category/category_controller.dart';

class ChooseCategoryBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<ChooseCategoryController>(ChooseCategoryController(),permanent: false);


  }

}