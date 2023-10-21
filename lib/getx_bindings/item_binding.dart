import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:beezar/modules/Screens/item_details/item_details_controller.dart';
import 'package:get/get.dart';

class ItemBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<ItemDetailsController>(ItemDetailsController(),permanent: false);


  }

}