import 'package:beezar/modules/Screens/add_product/add_item_controller.dart';
import 'package:get/get.dart';

class AddProductBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<AddItemController>(AddItemController(),permanent: true);


  }

}