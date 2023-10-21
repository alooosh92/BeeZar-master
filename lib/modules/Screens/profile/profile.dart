import 'package:beezar/config/server_config.dart';
import 'package:beezar/constants.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/Screens/profile/profile_controller.dart';
import 'package:beezar/modules/Screens/start.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_btn.dart';
import '../change_pass/change_pass.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    profile_controller controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'الصفحة الشخصية',
          style: TextStyle(fontFamily: "ca1"),
        ),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (controller.userController.user.email != null) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<profile_controller>(
                    init: profile_controller(),
                    builder: (c) => _profileimage(c)),
                SizedBox(
                  height: 25,
                ),
                _item(
                    AssetImage('assets/images/name.png'),
                    'الاسم',
                    controller.userController.user.name.toString(),
                    false,
                    () {}),
                _item(
                    AssetImage('assets/images/email.png'),
                    'البريد الالكتروني',
                    controller.userController.user.email.toString(),
                    false,
                    () {}),
                GetBuilder<profile_controller>(
                  builder: (c) => _item(
                      AssetImage('assets/images/password.png'),
                      'الباسورد',
                      c.userModel.password ?? "******",
                      true,
                      () => Get.to(ChangePass())),
                ),
                GetBuilder<profile_controller>(
                  builder: (c) => _item(
                      AssetImage('assets/images/phone.png'),
                      'الهاتف',
                      c.userModel.phone ?? c.userController.user.phone!,
                      true, () {
                    dialog(
                        'تغيير الهاتف',
                        () => c.changePhone(controller.textController[0].text),
                        0);
                  }),
                ),
                GetBuilder<profile_controller>(
                  builder: (c) =>
                      _dropdown(c, AssetImage('assets/images/address.png')),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: CustomBtn(
                    onTapBtn: () async {
                      await controller.saveChanges();
                    },
                    btnText: "حفظ التغيرات",
                    btnBgColor: mainColor,
                    btnTxtColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: ElevatedButton.icon(
                onPressed: () {
                  Get.offAll(StartPage());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(mainColor)),
                icon: Icon(Icons.login_outlined),
                label: Text(
                  "سجل دخول",
                  style: TextStyle(fontSize: 24),
                )),
          );
        }
      }),
    );
  }

  _dropdown(profile_controller c, image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
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
                  onChanged: (a) {
                    c.dropdownvalue = a!;
                    c.onChange(a);
                  },
                ),
              ),
            ],
          )),
    );
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
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            ),
            controller: controller.textController[controllerid]),
        title: title,
        onCancel: () {
          controller.textController[controllerid].clear();
          Get.back();
        },
        onConfirm: onPressed);
  }

  _item(image, String title, String body, bool edit, Function fun) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: 70,
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
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ca1"),
                      ),
                      Text(
                        body,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
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
                      icon: Icon(
                        Icons.edit,
                        color: itemColor,
                      ),
                      onPressed: () => fun(),
                    ))
                : SizedBox()
          ])),
    );
  }

  _profileimage(profile_controller c) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: CircleAvatar(radius: 60, backgroundImage: select(c)
                // child: select(c),
                ),
          ),
        ),
        Positioned(
            right: 95,
            bottom: 5,
            child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: itemColor,
                ),
                onPressed: () => c.pickImage()))
      ],
    );
  }

  select(profile_controller c) {
    profile_controller controller = Get.find();
    if (c.image == null) {
      if (sharedPrefs!.get("iamge") != null &&
          sharedPrefs!.get("iamge") != "") {
        return Image.network(
          "${ServerConfig.DNS}/public/${controller.userController.user.image}",
        ).image;
      } else {
        return Image.asset('assets/images/person.png').image;
      }
    } else {
      return FileImage(c.image!);
    }
  }
}
