// ignore_for_file: prefer_const_constructors

import 'package:beezar/modules/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../components/custom_btn.dart';
import '../../components/custom_textfeild1.dart';
import '../../constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  SignUpController controller = SignUpController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool Issecure = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                "مرحبًا بك يرجى تسجيل بياناتك الآن",
                                style: TextStyle(
                                    color: itemColor,
                                    fontSize: 15,
                                    fontFamily: "ca1",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: FormFields(
                                  "الاسم",
                                  const Icon(
                                    Icons.person,
                                  ),
                                  null,
                                  false,
                                  nameController, (value) {
                                controller.name = value;
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: FormFields(
                                  "البريد الاليكتروني",
                                  const Icon(
                                    Icons.email,
                                  ),
                                  null,
                                  false,
                                  emailController, (value) {
                                controller.email = value;
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: FormFields(
                                  "كلمة المرور",
                                  const Icon(
                                    Icons.lock,
                                  ),
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
                                controller.password = value;
                              }),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: MediaQuery.of(context).size.width * 0.02,
                            //       left:
                            //           MediaQuery.of(context).size.width * 0.01,
                            //       right:
                            //           MediaQuery.of(context).size.width * 0.01),
                            //   child: FormFields(
                            //       "العنوان",
                            //       const Icon(Icons.home),
                            //       null,
                            //       false,
                            //       addressController, (value) {
                            //     controller.address = value;
                            //   }),
                            // ),
                            GetBuilder<SignUpController>(
                                init: SignUpController(),
                                builder: (c) => _dropdown(c)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: FormFields(
                                  "رقم الهاتف المحمول",
                                  const Icon(Icons.phone),
                                  null,
                                  false,
                                  phoneController, (value) {
                                controller.phone = value;
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.02,
                                left: MediaQuery.of(context).size.width * 0.05,
                                right: MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: CustomBtn(
                                onTapBtn: () {
                                  registerOnclick();
                                },
                                btnText: 'تأكيد',
                                btnBgColor: mainColor,
                                btnTxtColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _dropdown(SignUpController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
          color: Colors.white),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(
            Icons.home,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 50),
            child: DropdownButton(
              // isExpanded: true,
              value: c.dropdownvalue,
              focusColor: Colors.grey.shade100,
              dropdownColor: Colors.white,
              // icon: const Icon(Icons.keyboard_arrow_down),
              items: itemsRegion.map((String items) {
                return DropdownMenuItem(
                  alignment: Alignment.centerRight,
                  value: items,
                  child: Text(
                    items,
                    // textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        fontSize: 20, fontFamily: 'ca1', color: Colors.black54),
                  ),
                );
              }).toList(),
              onChanged: (a) => c.onChange(a),
            ),
          ),
        ],
      ),
    );
  }

  registerOnclick() async {
    await controller.SignOnClick();
    EasyLoading.show(status: "Loading..");
    if (controller.SignUpStatuse == true) {
      await EasyLoading.showSuccess('Register Successfully');
      Get.offNamed('/policy');
    } else {
      EasyLoading.showError(controller.message);
      print(controller.message);
    }
  }
}
