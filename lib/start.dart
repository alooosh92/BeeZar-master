import 'package:beezar/components/custom_btn.dart';
import 'package:beezar/constants.dart';
import 'package:beezar/modules/Screens/start.dart';
import 'package:beezar/modules/login/login.dart';
import 'package:beezar/modules/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  StartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.30,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/lg.png"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'مرحباً بك ',
                      style: TextStyle(
                          fontSize: 30,
                          color: mainColor,
                          fontFamily: 'ca1',
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                        child: Text(
                      'يرجى تسجيل الدخول أو ادخال بياناتك للاشتراك ',
                      style: TextStyle(
                          fontSize: 16, color: titleColor, fontFamily: 'ca1'),
                    )),
                  ],
                ),
                Column(
                  children: [
                    CustomBtn(
                      onTapBtn: () {
                        _signUpBottonSheet(context);
                      },
                      btnText: ('اشترك الآن '),
                      btnBgColor: mainColor,
                      btnTxtColor: Colors.white,
                    ),
                    CustomBtn(
                      onTapBtn: () {
                        _logInBottonSheet(context);
                      },
                      btnText: (' تسجيل دخول'),
                      btnBgColor: mainColor,
                      btnTxtColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Future _signUpBottonSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => Container(
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.09,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: SignupPage(),
            ),
          ));
}

Future _logInBottonSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => Container(
            height: 800,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.09,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: LogIn(),
            ),
          ));
}
