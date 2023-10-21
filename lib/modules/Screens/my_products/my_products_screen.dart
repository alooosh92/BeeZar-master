import 'dart:io';

import 'package:beezar/config/server_config.dart';
import 'package:beezar/models/my_items.dart';
import 'package:beezar/modules/update/update_item.dart';
import 'package:beezar/modules/update/update_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import '../../../components/custom_btn.dart';
import '../../../components/small_nav.dart';
import '../../../constants.dart';
import 'my_products_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class MyProductsScreen extends StatelessWidget {
  TextEditingController srch = TextEditingController();
  MyProductController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(
              'اعلاناتي ',
              style: TextStyle(fontFamily: 'ca1', fontSize: 25),
            ),
            centerTitle: true,
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Get.toNamed('/choose');
            //       },
            //       icon: Icon(
            //         Icons.arrow_back_ios_new_rounded,
            //         size: 17,
            //         color: Colors.white,
            //       ))
            // ],
          ),
          // drawer:Drawerr(),
          body: ListView(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("لحذف الاعلان اضغط مطولاً على الاعلان المراد حذفه"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Obx(() {
                    if (controller.isLoading.value == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      );
                    } else {
                      return ListView(children: [
                        Column(
                          children: List.generate(
                              controller.productList.value.items.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/mydetail', arguments: [
                                        (controller.productList.value
                                            .items[index].name),
                                        (controller.productList.value
                                            .items[index].description),
                                        "${controller.productList.value.items[index].price}",
                                        (controller.productList.value
                                            .items[index].address),
                                        (controller.productList.value
                                            .items[index].nameUser),
                                        (controller.productList.value
                                            .items[index].images),
                                        (controller.productList.value
                                            .items[index].numberUser),
                                      ]);
                                    },
                                    onLongPress: () async {
                                      Get.defaultDialog(
                                        title: 'تحذير',
                                        actions: [
                                          Row(
                                            children: [
                                              SmallNav(
                                                  name: "موافق",
                                                  ontap: () async {
                                                    Get.back();
                                                    Get.dialog(const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ));
                                                    await controller.DeleteItem(
                                                        controller
                                                            .productList
                                                            .value
                                                            .items[index]
                                                            .id);
                                                    if (controller
                                                            .deleteDONE.value ==
                                                        true) {
                                                      await EasyLoading
                                                          .showSuccess(
                                                              'تم حذف الاعلان');
                                                      Get.back();

                                                      // Get.toNamed('/start');
                                                    } else {
                                                      EasyLoading.showError(
                                                          "فشل الحذف");
                                                    }
                                                    controller.isLoading.value =
                                                        true;
                                                    await controller
                                                        .getProducts();
                                                    print("end");
                                                    controller.isLoading.value =
                                                        false;
                                                  }),
                                              SmallNav(
                                                  name: "إلغاء",
                                                  ontap: () {
                                                    Get.back();
                                                  }),
                                            ],
                                          )
                                        ],
                                        content: Center(
                                          child: Text(
                                              'هل انت متأكد من حذف الاعلان\nلا يمكن التراجع عن هذا الخيار'),
                                        ),
                                        cancelTextColor: mainColor,
                                        buttonColor: mainColor,
                                      );
                                    },
                                    child: itemsP(
                                      file: controller.productList.value
                                          .items[index].images,
                                      address: controller.productList.value
                                          .items[index].address,
                                      cat: controller.productList.value
                                          .items[index].categoryId,
                                      sub: controller.productList.value
                                          .items[index].subCategoryId,
                                      pri: double.parse(controller
                                          .productList.value.items[index].price
                                          .toString()),
                                      item_id:
                                          "${controller.productList.value.items[index].id}",
                                      item_name: controller
                                          .productList.value.items[index].name,
                                      item_img: controller.productList.value
                                                  .items[index].images.length !=
                                              0
                                          ? "${controller.productList.value.items[index].images[0].path}/${controller.productList.value.items[index].images[0].name}"
                                          : "",
                                      item_imgs: controller.productList.value
                                                  .items[index].images.length !=
                                              0
                                          ? List.generate(
                                              controller.productList.value
                                                  .items[index].images.length,
                                              (i) =>
                                                  "${controller.productList.value.items[index].images[i].path}/${controller.productList.value.items[index].images[i].name}")
                                          : [],
                                      item_description: controller.productList
                                          .value.items[index].description,
                                      create_item_at:
                                          "${controller.productList.value.items[index].createdAt.toString().substring(0, 16)}",
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ]);
                    }
                  }),
                ),
                CustomBtn(
                  onTapBtn: () {
                    Get.offNamed('/choose');
                  },
                  btnBgColor: mainColor,
                  btnText: 'عودة للصفحة الرئيسية',
                  btnTxtColor: Colors.white,
                ),
              ],
            ),
          ]),
        ));
  }
}

class itemsP extends StatefulWidget {
  final String item_id;
  final String item_name;
  final String item_img;
  final List<String> item_imgs;
  final String item_description;
  final String create_item_at;
  final int sub;
  final int cat;
  final double pri;
  final String address;
  final List<ImageI> file;

  itemsP(
      {required this.item_id,
      required this.item_name,
      required this.item_img,
      required this.item_imgs,
      required this.item_description,
      required this.create_item_at,
      required this.cat,
      required this.pri,
      required this.sub,
      required this.address,
      required this.file});

  @override
  State<itemsP> createState() => _itemsPState();
}

class _itemsPState extends State<itemsP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.01,
          right: MediaQuery.of(context).size.width * 0.01,
          bottom: MediaQuery.of(context).size.width * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                      child: Column(
                        children: [
                          Text(
                            widget.item_name,
                            style: TextStyle(
                              fontFamily: 'ca1',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: mainColor,
                            ),
                          ),
                          Text(
                            "${widget.item_description.substring(0, 2)}...",
                            style: TextStyle(
                                fontFamily: 'ca1',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: textColor),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                                size: 15,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                widget.create_item_at,
                                style: TextStyle(
                                    fontFamily: 'ca1',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: textColor),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    var item = UpdateItemModel(
                                      description: widget.item_description,
                                      id: widget.item_id,
                                      name: widget.item_name,
                                      subCategoryId: widget.sub,
                                      categoryId: widget.cat,
                                      price: widget.pri,
                                      address: widget.address,
                                      file: [],
                                    );
                                    if (widget.file.isNotEmpty) {
                                      for (var element in widget.item_imgs) {
                                        http.Response i = await http.get(
                                            Uri.parse(
                                                "${ServerConfig.DNS}/$element"));
                                        if (i.statusCode == 200) {
                                          var dir =
                                              await getTemporaryDirectory();
                                          var filename =
                                              "${dir.path}/${element.split("/").last}";
                                          item.file!.add(File(filename));
                                          var im = item.file!.last;
                                          im.writeAsBytes(i.bodyBytes);
                                        }
                                      }
                                    }
                                    Get.to(UpdateItem(product: item));
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: mainColor,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 110,
                        width: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.teal[50],
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${Uri.parse("${ServerConfig.DNS}/${widget.item_img}")}",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: Color(0xff5e17eb),
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
