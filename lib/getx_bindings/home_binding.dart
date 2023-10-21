import 'package:beezar/modules/Screens/home/home_controller.dart';
import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:beezar/modules/user.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: false);
  }
}
