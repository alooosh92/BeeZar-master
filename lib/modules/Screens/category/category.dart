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

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController srch = TextEditingController();
  CategoryController controller = Get.find();

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
                      GridView.builder(
                        itemCount:
                            controller.CategoryList.value.categories.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/subcategory',
                                  arguments: controller
                                      .CategoryList.value.categories[index].id);
                            },
                            child: Card(
                              elevation: 30,
                              child: ListView(children: [
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
                                      width: 200,
                                      height: 150,
                                      child: controller.CategoryList.value
                                                  .categories[index].id ==
                                              "4"
                                          ? Image.asset(
                                              "assets/images/pets.jpg")
                                          : controller
                                                      .CategoryList
                                                      .value
                                                      .categories[index]
                                                      .image !=
                                                  "null"
                                              ? Image.network(
                                                  "${Uri.parse(ServerConfig.DNS + '/public' + '/' + controller.CategoryList.value.categories[index].image)}")
                                              : Image.asset("")),
                                ),
                              ]),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(5.0),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      ),
                    ]);
            })));
  }
}
