import 'dart:convert';
import 'dart:io';
import 'package:beezar/config/server_config.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UserModel {
  late String? name;
  late String? phone;
  late String? image;
  late String? email;
  late String? address;
  late String? userRole;
  late File? file;
  late String? password;
  late int? userId;

  UserModel({
    this.address,
    this.email,
    this.image,
    this.name,
    this.phone,
    this.userRole,
    this.file,
    this.password,
    this.userId,
  });

  factory UserModel.fromeJson(Map<String, dynamic> json) {
    return UserModel(
        address: json["data"]["address"],
        email: json["data"]["email"],
        image: json["data"]["image"],
        name: json["data"]["name"],
        phone: json["data"]["phone"],
        userRole: json["data"]["user_role"],
        userId: json["data"]["id"]);
  }
}

class UserController extends GetxController {
  UserModel user = UserModel();

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }

  Future<bool> getUser() async {
    http.Response response =
        await http.get(Uri.parse("${ServerConfig.DNS}/api/profile"), headers: {
      'Authorization': 'Bearer ${sharedPrefs!.get('id')}',
    });
    if (response.statusCode == 200) {
      user = UserModel.fromeJson(jsonDecode(response.body));
      profile_controller profile = Get.find();
      profile.dropdownvalue = user.address!;
      sharedPrefs!.setString("address", user.address!);
      sharedPrefs!.setString("email", user.email!);
      sharedPrefs!.setString("image", user.image!);
      sharedPrefs!.setString("name", user.name!);
      sharedPrefs!.setString("phone", user.phone!);
      return true;
    }
    return false;
  }

  Future<bool> updateUser(UserModel userModel) async {
    var b = await getUser();
    if (b) {
      if (user.image != null &&
          userModel.file == null &&
          user.image!.isNotEmpty) {
        http.Response i = await http
            .get(Uri.parse("${ServerConfig.DNS}/public/${user.image}"));
        if (i.statusCode == 200) {
          var dir = await getTemporaryDirectory();
          var filename = "${dir.path}/${user.image!.split("/").last}";
          userModel.file = File(filename);
          await userModel.file!.writeAsBytes(i.bodyBytes);
        }
      }
      if (!sharedPrefs!.containsKey("password") ||
          sharedPrefs!.getString("password") == null ||
          sharedPrefs!.getString("password") == "") {
        sharedPrefs!.setString("password", "12345678");
      }
      var newUser = UserModel(
        address: userModel.address ?? user.address,
        email: userModel.email ?? user.email,
        name: userModel.name ?? user.name,
        phone: userModel.phone ?? user.phone,
        password: sharedPrefs!.getString("password"),
        file: userModel.file ?? File("assets/images/person.png"),
        image: userModel.image ?? "assets/images/person.png",
      );
      http.MultipartRequest request = http.MultipartRequest(
          "post", Uri.parse(ServerConfig.DNS + ServerConfig.updateUser));
      request.headers.addAll({
        'Authorization': 'Bearer ${sharedPrefs!.get('id')}',
      });
      var f = await http.MultipartFile.fromPath("image", newUser.file!.path);
      request.files.add(f);
      request.fields["name"] = newUser.name!;
      request.fields["email"] = newUser.email!;
      request.fields["password"] = newUser.password!;
      request.fields["address"] =
          newUser.address ?? sharedPrefs!.getString("address")!;
      request.fields["phone"] = newUser.phone ?? "09XXXXXXXX";
      var req = await request.send();
      if (req.statusCode == 200) {
        await getUser();
        return true;
      }
    }

    return false;
  }
}
