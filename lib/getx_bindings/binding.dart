import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:beezar/modules/user.dart';
import 'package:get/get.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.put(profile_controller(), permanent: true);
  }
}
