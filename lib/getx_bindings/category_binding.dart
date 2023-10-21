import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:beezar/modules/Screens/home/home_controller.dart';
import 'package:get/get.dart';

import '../modules/Screens/choose_category/category_controller.dart';
import '../modules/Screens/profile/profile_controller.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies()
  {
      Get.put<CategoryController>(CategoryController(),permanent: true);
      Get.put<ChooseCategoryController>(ChooseCategoryController(),permanent: true);
      Get.put<profile_controller>(profile_controller(),permanent: true);
      Get.put<HomeController>(HomeController(),permanent: true);

  }

}