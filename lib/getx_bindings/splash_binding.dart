import 'package:beezar/modules/Screens/home/home_controller.dart';
import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:beezar/modules/Screens/splash/splash_controller.dart';
import 'package:beezar/modules/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: false);
  }
}
