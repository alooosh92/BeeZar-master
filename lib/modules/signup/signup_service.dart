import 'dart:convert';
import 'package:beezar/main.dart';
import 'package:beezar/modules/user.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/server_config.dart';
import '../../models/my_user.dart';

class SignUpService {
  var url = Uri.parse(ServerConfig.DNS + ServerConfig.signup);
  // var url1 = Uri.parse(ServerConfig.DNS+ServerConfig.login);
  var message;
  var error;
  var token;

  Future<bool> register(NewUser user) async {
    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'name': user.name,
        'password': user.password,
        'email': user.email,
        'address': user.address,
        'phone': user.phone,
      },
    );

    if (response.statusCode == 200) {
      UserController userController = Get.find();
      await userController.getUser();
      final sp = await SharedPreferences.getInstance();
      await sp.setString(
          'id', json.decode(response.body)["access_token"].toString());
      await sharedPrefs!.setString("password", user.password);

      await userController.getUser();
      var jsonResponse = jsonDecode(response.body);
      // message=jsonResponse['success'];
      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      //  message= jsonResponse['errors'];
      return false;
    } else if (response.statusCode == 500) {
      var jsonResponse = jsonDecode(response.body);
      //  message= jsonResponse['errors'];
      return false;
    } else {
      var jsonResponse = jsonDecode(response.body);
      // message= jsonResponse['errors'];
      return false;
    }
  }
}
