
import 'package:beezar/modules/Screens/my_item_details/item_details_controller.dart';
import 'package:get/get.dart';

class MyItemDetailsBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<MyItemDetailsController>(MyItemDetailsController(),permanent: false);


  }

}