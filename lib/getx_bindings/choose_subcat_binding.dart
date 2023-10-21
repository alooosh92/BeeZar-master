import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:get/get.dart';

import '../modules/Screens/choose_category/category_controller.dart';
import '../modules/Screens/choose_subcategory/sub_category_controller.dart';

class ChooseSubCategoryBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<ChooseSubCategoryController>(ChooseSubCategoryController(),permanent: false);


  }

}