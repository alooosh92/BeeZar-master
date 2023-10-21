import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:beezar/modules/Screens/subCategory/sub_category_controller.dart';
import 'package:get/get.dart';

class SubCategoryBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<SubCategoryController>(SubCategoryController(),permanent: false);


  }

}