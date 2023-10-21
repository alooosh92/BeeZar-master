import 'package:get/get.dart';

class MyItemDetailsController extends GetxController {

  var isLoading = true.obs;
  var name;
  var des;
  var price;
  var address;
  var userName;
  var image=[];
  var userNumber;
  var images;

  @override
  void onInit()async{
    super.onInit();
    print("let go");
    name =Get.arguments[0];
    des =Get.arguments[1];
    price =Get.arguments[2];
    address =Get.arguments[3];
    userName =Get.arguments[4];
    image =Get.arguments[5];
    userNumber =Get.arguments[6];




    print("end");
    isLoading.value=false;
  }



}
