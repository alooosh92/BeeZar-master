import 'dart:convert';
import 'package:beezar/constants.dart';
import 'package:beezar/main.dart';
import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../config/server_config.dart';
import '../../Drawer/drawer.dart';
import 'package:http/http.dart' as http;

import '../subCategory/sub_category.dart';
import 'category_controller.dart';

class ChooseCategory extends StatefulWidget {
  ChooseCategory({super.key});

  @override
  State<ChooseCategory> createState() => _homePageState();
}

class _homePageState extends State<ChooseCategory> {
  TextEditingController srch = TextEditingController();
  ChooseCategoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: Container(
                  height: 40,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      controller.Search(value);
                    },
                    controller: srch,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        label: Text(
                          'بحث',
                          style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontFamily: 'reg'),
                        )),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            drawer: Drawerr(),
            body: Obx(() {
              return (controller.isLoading.value == true)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : Stack(children: [
                      ListView(
                        children: [
                          Text(
                            'اختر تصنيف منتجك',
                            style: TextStyle(
                                fontSize: 30,
                                color: mainColor,
                                fontFamily: 'ca1'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            itemCount:
                                controller.CategoryList.value.categories.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (sharedPrefs!.getString("email") == null ||
                                      sharedPrefs!
                                          .getString("email")!
                                          .isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actions: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: mainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: IntrinsicHeight(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'إلغاء',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: mainColor,
                                                              fontFamily: 'ca1',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                  } else {
                                    Get.toNamed('/choose_sub_category',
                                        arguments: controller.CategoryList.value
                                            .categories[index].id);
                                  }
                                },
                                child: Card(
                                  elevation: 30,
                                  child: Column(children: [
                                    Center(
                                        child: Text(
                                      controller.CategoryList.value
                                          .categories[index].name,
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          fontFamily: 'ca1'),
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: controller.CategoryList.value
                                                        .categories[index].id ==
                                                    "4"
                                                ? Image.asset(
                                                    "assets/images/pets.jpg")
                                                : Image.network(
                                                    "${Uri.parse(ServerConfig.DNS + '/' + 'public' + '/' + controller.CategoryList.value.categories[index].image)}",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Text(
                                                            "خطأ بتحميل الصورة"),
                                                      );
                                                    },
                                                  ))),
                                  ]),
                                ),
                              );
                            },
                            padding: EdgeInsets.all(5.0),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                          ),
                        ],
                      ),
                    ]);
            })));
  }
}
