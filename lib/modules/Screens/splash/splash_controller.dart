import 'package:get/get.dart';


class SplashController extends GetxController{




  @override
  void onInit() async{
    await Future.delayed(const Duration(seconds: 4));
    Get.offNamed('/start');
    super.onInit();
  }
  @override
  void onReady() async{

    super.onReady();

  }



}