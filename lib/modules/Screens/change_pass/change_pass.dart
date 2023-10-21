
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_btn.dart';
import '../../../components/custom_textfeild1.dart';
import '../../../constants.dart';
import '../profile/profile_controller.dart';

class ChangePass extends StatefulWidget {
  ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final controller = Get.put(profile_controller());
  bool passwordVisible = false;
  bool Issecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: mainColor,
          title:  Text('تغيير كلمة المرور', style: TextStyle(fontFamily: 'ca1'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10, top: 20),
          child: Column(
            children: [
              FormFields(
                "كلمة المرور الحالية",
                const Icon(Icons.lock,color:Color(0xffc86ea0)),
                IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,color: itemColor,
                  ),
                  onPressed: () {
                    setState(() {
                      Issecure = !Issecure;
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                Issecure,
                controller.textController[2],
                    (a) {},),
              SizedBox(height: 20,),
              FormFields(
                "كلمة المرور الجديدة",
                const Icon(Icons.lock,color:Color(0xffc86ea0),),
                IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,color: itemColor,
                  ),
                  onPressed: () {
                    setState(() {
                      Issecure = !Issecure;
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                Issecure,
                controller.textController[3],
                    (a) {},),
              SizedBox(height: 20,),
              FormFields(
                  "تأكيد كلمة المرور الجديدة",
                  const Icon(Icons.lock,color: Color(0xffc86ea0),),
                  IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,color: itemColor,
                    ),
                    onPressed: () {
                      setState(() {
                        Issecure = !Issecure;
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  Issecure,
                controller.textController[4],
                   (a) {},),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomBtn(
                    onTapBtn: () => controller.changePassword(),
                    btnText: "تأكيد", btnBgColor: mainColor, btnTxtColor:Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
