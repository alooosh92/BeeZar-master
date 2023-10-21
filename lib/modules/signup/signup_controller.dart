import 'package:beezar/modules/signup/signup_service.dart';
import 'package:get/get.dart';

import '../../models/my_user.dart';

SignUpService service = SignUpService();

class SignUpController extends GetxController {
  var keep = false;
  var name;
  var address;
  var phone;
  var image = null;
  var email;
  var password;
  var SignUpStatuse = false;
  var message;
  String dropdownvalue = 'حلب';

  Future<void> SignOnClick() async {
    NewUser users = NewUser(
        name: name,
        email: email,
        password: password,
        address: dropdownvalue,
        phone: phone);

    SignUpStatuse = await service.register(users);

    if (message is List) {
      String temp = '';
      for (String s in message) {
        temp += s + '\n';
        message = temp;
      }
    }
  }

  onChange(String? newValue) {
    dropdownvalue = newValue!;
    update();
  }
}
