import 'package:beezar/components/custom_btn.dart';
import 'package:beezar/constants.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/Screens/home/homePage.dart';
import 'package:beezar/modules/Screens/home/home_controller.dart';
import 'package:beezar/modules/Screens/my_products/my_products_controller.dart';
import 'package:beezar/modules/update/update_controller.dart';
import 'package:beezar/modules/update/update_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateItem extends StatelessWidget {
  const UpdateItem({super.key, required this.product});
  final UpdateItemModel product;
  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    UpdateController updateController = Get.put(UpdateController());
    TextEditingController name = TextEditingController(text: product.name);
    TextEditingController price =
        TextEditingController(text: product.price.toString());
    updateController.dropDown = product.address;
    TextEditingController des =
        TextEditingController(text: product.description);

    if (product.file != null) {
      updateController.selectedImages = product.file!;
    }
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
              child: Column(
                children: [
                  GetBuilder<UpdateController>(
                    init: updateController,
                    builder: (controller) {
                      return Column(
                        children: [
                          _container1(controller),
                          _padding1(controller),
                          Visibility(
                            visible: controller.selectedImages.isNotEmpty,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: CustomBtn(
                                btnBgColor: Colors.red,
                                btnText: 'حذف الصورة',
                                btnTxtColor: Colors.white,
                                onTapBtn: () {
                                  controller.deleteImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  _textField2(
                    'اسم المنتج',
                    name,
                    1,
                    maxlegth: 15,
                    validator: "الرجاء ادخال اسم المنتج أقل من 15 محرف",
                    onch: (val) => product.name = val,
                  ),
                  _textField2(
                    'سعر المنتج',
                    price,
                    1,
                    textInputType: TextInputType.number,
                    validator: "الرجاءادخال سعر المنتج",
                    onch: (val) => product.price = double.parse(val),
                  ),
                  //  _dropdown(updateController),
                  _textField2(
                    'وصف المنتج',
                    des,
                    2,
                    onch: (val) => product.description = val,
                  ),
                  CustomBtn(
                    btnText: 'تعديل الاعلان',
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: mainColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                      if (updateController.listImage.isEmpty) {
                        Get.snackbar("خطأ", "الرجاء تحميل صورة واحدة على الأقل",
                            backgroundColor: mainColor,
                            colorText: Colors.white);
                      }
                      if (form.currentState!.validate() &&
                          updateController.listImage.isNotEmpty) {
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var b = await updateController.updateItem(product);
                      if (b) {
                        HomeController controller = Get.find();
                        MyProductController productController = Get.find();
                        await controller.getallProducts();
                        await productController.getProducts();
                        await Get.offAllNamed('/choose');
                      } else {
                        Get.snackbar("خطأ", "حصل خطأ ما تواصل مع المسؤول");
                      }
                    },
                    btnBgColor: mainColor,
                    btnTxtColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownRegion extends StatelessWidget {
  const DropDownRegion({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> list = [];
    for (var element in itemsRegion) {
      list.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    }
    UpdateController updateController = Get.find();
    return GetBuilder<UpdateController>(
        init: updateController,
        builder: (controller) {
          return DropdownButton<String>(
            borderRadius: BorderRadius.circular(10),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'ca1', color: Colors.black54),
            items: list,
            onChanged: (value) {
              controller.updateRegion(value!);
            },
            value: controller.dropDown,
          );
        });
  }
}

_dropdown(UpdateController c) {
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
          child: GetBuilder<UpdateController>(
              init: c,
              builder: (controller) {
                return DropdownButton(
                  // isExpanded: true,
                  value: c.dropDown,
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
                            fontSize: 20,
                            fontFamily: 'ca1',
                            color: Colors.black54),
                      ),
                    );
                  }).toList(),
                  onChanged: (a) => c.updateRegion(a!),
                );
              }),
        ),
      ],
    ),
  );
}

_padding1(UpdateController controller) {
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

Container _container1(UpdateController c) {
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
      child: c.listImage.isEmpty // If no images is selected
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: c.listImage.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    child: Image.asset(fit: BoxFit.cover, c.listImage[index]));
              })
          : GridView.builder(
              itemCount: c.selectedImages.isEmpty
                  ? c.listImage.length
                  : c.selectedImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                // TO show selected file
                return Center(
                    child: c.selectedImages.isEmpty
                        ? Image.asset(c.listImage[index])
                        : Image.file(c.selectedImages[index]));
              },
            ),
    ),
  );
}

_textField2(String hint, TextEditingController controller, int max,
    {TextInputType? textInputType,
    String? validator,
    int? maxlegth,
    void Function(String val)? onch}) {
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
        onChanged: onch,
        keyboardType: textInputType,
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
