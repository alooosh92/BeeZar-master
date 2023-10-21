import 'dart:convert';

import 'package:beezar/config/server_config.dart';
import 'package:beezar/main.dart';
import 'package:beezar/models/my_user.dart';
import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:beezar/modules/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  var url = Uri.parse(ServerConfig.DNS + ServerConfig.login);
  var message;
  var error;
  var token;

  Future<bool> login(User user) async {
    try {
      var response = await http.post(url, headers: {
        'Accept': 'application/json',
      }, body: {
        'email': user.email,
        'password': user.password,
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        await sharedPrefs!.setString("password", user.password);
        sharedPrefs!.setString("id", body["token"]);
        profile_controller userController = Get.find();
        await userController.userController.getUser();
        // var b = jsonDecode(response.body);
        // final sp = await SharedPreferences.getInstance();
        // await sp.setString(
        //     'id', json.decode(response.body)["token"].toString());
        // await sp.setString("email", user.email);
        // await sp.setString(
        //     "name", json.decode(response.body)["user"]["name"].toString());
        // await sp.setString(
        //     "phone", json.decode(response.body)["user"]["phone"].toString());
        // await sp.setString("password", user.password);
        // await sp.setString(
        //     "image",
        //     json
        //         .decode(response.body)["user"]["image"]
        //         .toString()
        //         .split("/")
        //         .last);
        // //   Get.back();
        return true;
      } else {
        // Get.back();
        print(jsonDecode(response.body));
        return false;
      }
    } catch (e) {
      print('$e + messageeeeeeeeeee');
      return false;
    }
  }
}
