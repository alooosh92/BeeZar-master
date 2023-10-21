import 'package:beezar/constants.dart';
import 'package:beezar/modules/Screens/add_product/add_item_controller.dart';
import 'package:beezar/modules/Screens/home/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_btn.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../main.dart';

class AddItem extends StatelessWidget {
  AddItemController controller = Get.find();

  List<String> imgs = [
    'assets/images/add.png',
    'assets/images/add.png',
    'assets/images/add.png'
  ];

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text(
            'إضافة اعلان',
            style: TextStyle(fontFamily: "ca1"),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: form,
            autovalidateMode: AutovalidateMode.always,
            child: Column(children: [
              GetBuilder<AddItemController>(
                  init: AddItemController(),
                  builder: (c) {
                    return Column(
                      children: [
                        _container1(c),
                        _padding1(),
                        Visibility(
                          visible: controller.selectedImages.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: CustomBtn(
                                btnBgColor: Colors.red,
                                btnText: 'حذف الصورة',
                                btnTxtColor: Colors.white,
                                onTapBtn: () {
                                  controller.deleteImage();
                                }),
                          ),
                        ),
                      ],
                    );
                  }),

              _textField2('اسم المنتج', controller.textController[1], 1,
                  (value) {
                controller.name = value;
              },
                  maxlegth: 15,
                  validator: "الرجاء ادخال اسم المنتج أقل من 15 محرف"),
              _textField2('سعر المنتج', controller.textController[2], 1,
                  (value) {
                controller.price = value;
              },
                  textInputType: TextInputType.number,
                  validator: "الرجاءادخال سعر المنتج"),
              GetBuilder<AddItemController>(
                  init: AddItemController(), builder: (c) => _dropdown(c)),
              _textField2('وصف المنتج', controller.textController[4], 2,
                  (value) {
                controller.des = value;
              }, validator: "الرجاء ادخال وصف للمنتج"),
              // _padding2(),
              CustomBtn(
                btnText: 'نشر الاعلان',
                onTapBtn: () async {
                  if (sharedPrefs!.getString("email") == null ||
                      sharedPrefs!.getString("email")!.isEmpty) {
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
                                    border:
                                        Border.all(width: 2, color: mainColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            title: const Center(
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
                  if (controller.selectedImages.isEmpty) {
                    Get.snackbar("خطأ", "الرجاء تحميل صورة واحدة على الأقل",
                        backgroundColor: mainColor, colorText: Colors.white);
                  }
                  if (form.currentState!.validate() &&
                      controller.selectedImages.isNotEmpty) {
                    Get.dialog(const Center(
                      child: CircularProgressIndicator(),
                    ));
                    await controller.AddItem();
                    Get.back();
                    if (controller.Done.value == true) {
                      await EasyLoading.showSuccess('تم نشر الاعلان');
                      controller.clear();
                      HomeController home = Get.find();
                      await home.getallProducts();
                      Get.offNamed('/my_items');
                    } else {
                      EasyLoading.showError("فشل الاضافة");
                    }
                  }
                },
                btnBgColor: mainColor,
                btnTxtColor: Colors.white,
              ),
            ]),
          ),
        )),
      ),
    );
  }

  _padding1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomBtn(
          btnBgColor: mainColor,
          btnText: 'تحميل صورة',
          btnTxtColor: Colors.white,
          onTapBtn: () {
            controller.getImages();
          }),
    );
  }

  Container _container1(AddItemController c) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: mainColor),
        borderRadius: BorderRadius.circular(15),
      ),
      // width: 150,
      height: 120,
      child: SizedBox(
        width: 170.0, // To show images in particular area only
        child: c.selectedImages.isEmpty // If no images is selected
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgs.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 150,
                      height: 150,
                      child: Image.asset(fit: BoxFit.cover, imgs[index]));
                })
            : GridView.builder(
                itemCount: c.selectedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  // TO show selected file
                  return Center(
                      child: kIsWeb
                          ? Image.network(c.selectedImages[index].path)
                          : Image.file(c.selectedImages[index]));
                },
              ),
      ),
    );
  }

  _textField2(
      String hint, TextEditingController controller, int max, var onChanged,
      {TextInputType? textInputType, String? validator, int? maxlegth}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 75,
        width: double.infinity,
        child: TextFormField(
          maxLength: maxlegth,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validator;
            }
            return null;
          },
          keyboardType: textInputType,
          onChanged: onChanged,
          maxLines: max,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            floatingLabelStyle: TextStyle(color: textColor, fontFamily: "ca1"),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'ca1',
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: mainColor,
              ),
            ),
            labelText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          controller: controller,
        ),
      ),
    );
  }

  _dropdown(AddItemController c) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
          color: Colors.white),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              "العنوان",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
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
}
