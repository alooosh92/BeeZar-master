import 'package:beezar/config/server_config.dart';
import 'package:beezar/modules/Screens/start.dart';
import 'package:beezar/modules/login/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  var url = Uri.parse(ServerConfig.DNS + ServerConfig.logout);

  Future<bool> logout() async {
    try {
      final sp = await SharedPreferences.getInstance();
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${sp.getString('id')}',
          'Accept': 'application/json',
        },
        body: {},
      );
      if (response.statusCode == 200) {
        final sp = await SharedPreferences.getInstance();
        await sp.clear();
        await sp.remove("id");
        await sp.remove("email");
        await sp.remove("name");
        await sp.remove("token");
        await sp.remove("_idToken");
        await sp.remove("_idToken");
        await sp.remove("photoUrl");
        await sp.remove("displayName");

        Get.offAll(LogIn());
        return true;
      } else {
        final sp = await SharedPreferences.getInstance();
        await sp.clear();
        await sp.remove("id");
        await sp.remove("email");
        await sp.remove("name");
        Get.offAll(LogIn());
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
