import 'package:beezar/Middleware/GoogleSignInApi.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/signup/signup_service.dart';
import 'package:beezar/modules/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/my_user.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  var keep = false;
  late String email;
  late String password;
  var LoginStatuse = false;
  var message;
  bool passwordVisible = false;
  bool Issecure = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var user;

  SignUpService SignUpservice = SignUpService();
  LoginService loginService = LoginService();

  Future<bool> LoginOnClick() async {
    var responce = await loginService.login((User(
      email: email,
      password: password,
    )));
    if (responce) {
      Get.toNamed('/home');
      return true;
    } else {
      print(responce.toString());
      //  message = service.error;

      if (message is List) {
        String temp = '';
        for (String s in message) {
          temp += s + '\n';
          message = temp;
        }
      }
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 5),
        title: "",
        message: "برجاء العلم حدثت مشكله بتسجيل الدخول",
      ));
      return false;
    }
  }

  void changeState() {
    Issecure = !Issecure;
    passwordVisible = !passwordVisible;
    update();
  }

  Future<void> SignOnWithGoogle() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      Get.snackbar("title", "Nooooooooooooooooooo user ");
    } else {
      Get.snackbar(
        "مرحباً بك ",
        "أهلا بك${user.email} بتطبيق بيزار ",
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      if (await SignUpservice.register(
            NewUser(
                name: user.displayName!,
                email: user.email,
                password: "12345678",
                address: "syr",
                phone: "09873733"),
          ) ==
          true) {
        await SignUpservice.register(
          NewUser(
              name: user.displayName!,
              email: user.email,
              password: "12345678",
              address: "syr",
              phone: "09873733"),
        );
      } else {
        loginService.login((User(
          email: user.email,
          password: "12345678",
        )));
      }
      UserController userController = Get.find();
      await userController.getUser();
      Get.offNamed('/choose');
    }
    // final sp = await SharedPreferences.getInstance();
    // await sp.setString('id', user!.id);
    // await sp.setString("email", user.email);
    // await sp.setString("name", user.displayName!);
    // await sp.setString("phone", "");
  }
}
