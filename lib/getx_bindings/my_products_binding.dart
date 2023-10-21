
import 'package:beezar/modules/Screens/my_products/my_products_controller.dart';
import 'package:get/get.dart';

class MyItemBinding extends Bindings{
  @override
  void dependencies()
  {
    Get.put<MyProductController>(MyProductController(),permanent: false);


  }

}