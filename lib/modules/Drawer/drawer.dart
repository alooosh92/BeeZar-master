import 'package:beezar/config/server_config.dart';
import 'package:beezar/modules/Screens/contactUs.dart';
import 'package:beezar/modules/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../main.dart';
import '../Screens/change_pass/change_pass.dart';
import '../Screens/profile/profile_controller.dart';
import '../logout/logout.dart';
import '../signup/Usage policy.dart';

class Drawerr extends StatelessWidget {
  Drawerr({super.key});

  @override
  Widget build(BuildContext context) {
    profile_controller controller = Get.find();
    return Drawer(
      child: ListView(
        children: [
          GetBuilder<profile_controller>(
              init: profile_controller(), builder: (c) => _profileimage(c)),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.offAllNamed('/choose');
                  },
                  child: ListTile(
                    onTap: () => Get.offAllNamed('/choose'),
                    title: Text(
                      "الصفحة الرئيسية",
                      style: TextStyle(
                          color: textColor, fontSize: 20.0, fontFamily: 'ca1'),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: itemColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: itemColor,
                      size: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: <Widget>[],
            ),
          ),
          ExpansionTile(
            title: Text(
              "حسابي",
              style: TextStyle(
                  color: textColor, fontSize: 20.0, fontFamily: 'ca1'),
            ),
            children: <Widget>[
//======================child account
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    _item(
                        AssetImage('assets/images/name.png'),
                        'الاسم',
                        controller.userController.user.name.toString(),
                        false,
                        () {},
                        context),
                    _item(
                        AssetImage('assets/images/email.png'),
                        'البريد الالكتروني',
                        controller.userController.user.email.toString(),
                        false,
                        () {},
                        context),
                    GetBuilder<profile_controller>(
                      builder: (c) => _item(
                          AssetImage('assets/images/password.png'),
                          'كلمة المرور',
                          "********",
                          true,
                          () => Get.to(ChangePass()),
                          context),
                    ),
                    GetBuilder<profile_controller>(
                      builder: (c) => _item(
                          AssetImage('assets/images/phone.png'),
                          'الهاتف',
                          controller.userController.user.phone.toString(),
                          true, () {
                        dialog(
                            'تغيير الهاتف',
                            () => c
                                .changePhone(controller.textController[0].text),
                            0);
                      }, context),
                    ),
                    GetBuilder<profile_controller>(
                      builder: (c) =>
                          _dropdown(c, AssetImage('assets/images/address.png')),
                    ),
                  ],
                ),
              ),

              //======================end child account
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Divider(
              color: Colors.grey[500],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    if (sharedPrefs!.getString("id") == null) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: mainColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'إلغاء',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: mainColor,
                                                fontFamily: 'ca1',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: mainColor,
                                          width: 80,
                                          thickness: 2,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed('/start');
                                          },
                                          child: Text(
                                            'موافق',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: mainColor,
                                                fontFamily: 'ca1',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                              title: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'يجب تسجيل الدخول',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ca1',
                                          fontSize: 30),
                                    ),
                                    Text(
                                      'تسجيل الدخول الآن ؟',
                                      style: TextStyle(
                                        fontFamily: 'ca1',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    Get.back();
                    Get.toNamed('/my_items');
                  },
                  child: ListTile(
                    title: Text(
                      "عرض اعلاناتي",
                      style: TextStyle(
                          color: textColor, fontSize: 20.0, fontFamily: 'ca1'),
                    ),
                    leading: Icon(
                      Icons.list_alt_outlined,
                      color: itemColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(UsagePolicy());
                  },
                  child: ListTile(
                    title: Text(
                      "شروط الاستخدام",
                      style: TextStyle(
                          color: textColor, fontSize: 20.0, fontFamily: 'ca1'),
                    ),
                    leading: Icon(
                      Icons.list_alt_outlined,
                      color: itemColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Container(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.to(ContactUsScreen());
                        },
                        child: ListTile(
                          title: Text(
                            "تواصل معنا",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20.0,
                                fontFamily: 'ca1'),
                          ),
                          leading: Icon(
                            Icons.list_alt_outlined,
                            color: itemColor,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          bool result = await LogoutService().logout();
                          // await GoogleSignInApi.logout();
                          if (result) {
                            final sp = await SharedPreferences.getInstance();
                            await sp.clear();
                          }
                          Get.offAllNamed('/start');
                        },
                        child: ListTile(
                          title: Text(
                            controller.userController.user.userId.toString() ==
                                    "null"
                                ? "سجل دخول الأن"
                                : "تسجيل خروج",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20.0,
                                fontFamily: 'ca1'),
                          ),
                          leading: Icon(
                            controller.userController.user.userId.toString() ==
                                    "null"
                                ? Icons.login_outlined
                                : Icons.logout_outlined,
                            color: itemColor,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _dropdown(profile_controller c, image) {
    return Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 65,
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 18),
            color: Colors.white,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 50),
                  child: DropdownButton(
                    // isExpanded: true,
                    value: c.dropdownvalue,
                    focusColor: Colors.grey.shade100,
                    dropdownColor: Colors.white,
                    // icon: const Icon(Icons.keyboard_arrow_down),
                    items: c.items.map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: items,
                        child: Text(
                          items,
                          // textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (a) => c.onChange(a),
                  ),
                ),
              ],
            )));
  }

  dialog(title, onPressed, int controllerid) {
    profile_controller controller = Get.find();
    Get.defaultDialog(
        content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            controller: controller.textController[controllerid]),
        title: title,
        onCancel: () {
          controller.textController[controllerid].clear();
          Get.back();
        },
        onConfirm: onPressed);
  }

  _item(image, String title, String body, bool edit, Function fun,
      BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              width: MediaQuery.sizeOf(context).width * 0.67,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 65,
              child: Stack(children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage: image,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ca1"),
                          ),
                          Text(
                            body,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                edit
                    ? Positioned(
                        top: 9,
                        left: 10,
                        child: IconButton(
                          // color: Colors.white,
                          icon: Icon(Icons.edit),
                          onPressed: () => fun(),
                        ))
                    : SizedBox()
              ])),
        ),
      ],
    );
  }

  _profileimage(profile_controller c) {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: select(c),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () => c.pickImage()),
                Text(
                  " مرحباً بك ",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20.0, fontFamily: 'ca1'),
                ),
                Text(
                  sharedPrefs!.getString("email").toString() == "null"
                      ? "الرجاء تسجيل الدخول"
                      : sharedPrefs!.getString("email").toString(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 20.0, fontFamily: 'ca1'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  select(profile_controller c) {
    if (c.image == null) {
      if (sharedPrefs!.get("iamge") != null &&
          sharedPrefs!.get("iamge") != "") {
        return Image.network(
          "${ServerConfig.DNS}/public/${c.userController.user.image}",
        ).image;
      } else {
        return Image.asset('assets/images/person.png').image;
      }
    } else {
      return FileImage(c.image!);
    }
  }
}
