import 'dart:convert';

import 'package:beezar/components/custom_btn.dart';
import 'package:beezar/components/custom_textfeild1.dart';
import 'package:beezar/config/server_config.dart';
import 'package:beezar/constants.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/Screens/category/category.dart';
import 'package:beezar/modules/login/facebooklogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signup/signup_controller.dart';
import 'login_controller.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginController loginController = LoginController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool Issecure = true;

  var token;
  var img;
  var name;
  var googleMail;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "مرحبًا بعودتك يرجى تسجيل الدخول الآن",
                    style: TextStyle(
                        color: itemColor,
                        fontSize: 15,
                        fontFamily: "ca1",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.07,
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: FormFields(
                      "البريد الاليكتروني",
                      const Icon(Icons.email),
                      null,
                      false,
                      emailController, (value) {
                    loginController.email = value;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.03,
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: FormFields(
                      "كلمة المرور",
                      const Icon(Icons.lock),
                      IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            Issecure = !Issecure;
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      Issecure,
                      passwordController, (value) {
                    loginController.password = value;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Column(
                    children: [
                      CustomBtn(
                        onTapBtn: () async {
                          Get.dialog(const Center(
                            child: CircularProgressIndicator(),
                          ));
                          if (formKey.currentState!.validate()) {
                            final sp = await SharedPreferences.getInstance();
                            await sp.setString('email', emailController.text);
                            loginOnclick();
                          }
                        },
                        btnText: 'تأكيد',
                        btnBgColor: mainColor,
                        btnTxtColor: Colors.white,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'او سجل الدخول بواسطة',
                        style: TextStyle(
                          fontFamily: 'ca1',
                          color: Colors.black,
                        ),
                      ),
                      faceBtn(onTapBtn: () async {
                        _facebookLogin();
                      }),
                      googleBtn(onTapBtn: () async {
                        Get.dialog(const Center(
                          child: CircularProgressIndicator(),
                        ));
                        sharedPrefs?.setString('_idToken', '$token');
                        sharedPrefs?.setString('photoUrl', '$img');
                        sharedPrefs?.setString('email', '$googleMail');
                        sharedPrefs?.setString('displayName', '$name');
                        await loginController.SignOnWithGoogle();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FacebookLogin _fb = FacebookLogin();
  loginOnclick() async {
    final result = await loginController.LoginOnClick();
    if (result) {
      await EasyLoading.showSuccess('Register Successfully');
      Get.offAllNamed('/choose');
    }
  }

  void _facebookLogin() async {
    final result = await _fb.logIn();
    switch (result.status) {
      case FacebookLoginStatus.success:
        sendToken(result.accessToken!.token);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage()));
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print(result.error);
        break;
    }
  }

  void sendToken(String facebookToken) async {
    http.Response response =
        await http.post(Uri.parse(ServerConfig.DNS + ServerConfig.login),
            body: json.encode({
              "remember_token": facebookToken,
            }),
            headers: {"Content-Type": "applicaton/json"});
    print(response.body);
  }

  /*_facebookLogin() async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile, //permission to get public profile
      FacebookPermission.email, //permission to got email
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken =
            res.accessToken; // get access token for auth login
        final profile = await fb.getUserProfile(); // get user's profile
        final imageUrl =
            await fb.getProfileImageUrl(width: 100); // get user's profile image
        final email = await fb.getUserEmail(); //get user's email

        print('Access token: ${accessToken?.token}');
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        print('Your profile image: $imageUrl');
        if (email != null) print('And your email is $email');

        //push to success page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessLoginPage(
                      fbAccessToken: accessToken!.token,
                      profileImage: imageUrl!,
                      fbName: profile.name!,
                      fbId: profile.userId,
                      fbEmail: email!,
                    )));

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
*/
}
