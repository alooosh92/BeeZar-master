import 'package:flutter/material.dart';
import '../../../components/custom_btn.dart';
import '../../../config/server_config.dart';
import '../../../constants.dart';
import 'package:get/get.dart';
import '../../../models/subCategory_model.dart';
import '../../Drawer/drawer.dart';
import 'home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.find();
  var current;
  var currentItem;
  var currentSubItem;

  TextEditingController srch = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: Drawerr(),
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    current = null;
                  });
                   controller.SubCategoryList =SubCategory(subcategories: []).obs;

                  await controller.getallProducts();

                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .2,
                  height: MediaQuery.of(context).size.height * .04,
                  decoration: BoxDecoration(
                    color: Color(0xfff0ebfa),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "الأحدث",
                      style: TextStyle(
                          fontFamily: 'ca1',
                          color: mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
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
                  onChanged: (value) async {
                    await controller.Search(value);
                  },
                  controller: srch,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      hintText: "بحث"),
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .07,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            controller.CategoryList.value.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Get.dialog(const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                  await controller.ChangeId(controller
                                      .CategoryList.value.categories[index].id);
                                  Get.back();
                                  setState(() {
                                    current = index;
                                     currentItem=null;
                                     currentSubItem=null;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  margin: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width * .2,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff0ebfa),
                                    borderRadius: current == index
                                        ? BorderRadius.circular(15)
                                        : BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.CategoryList.value
                                          .categories[index].name,
                                      style: TextStyle(
                                          fontFamily: 'ca1',
                                          color: current == index
                                              ? mainColor
                                              : textColor,
                                          fontSize: current == index ? 17 : 15,
                                          fontWeight: current == index
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: current == index,
                                child: Container(
                                  height: 2,
                                  width: 60,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height:
                        (controller.SubCategoryList.value.subcategories.isEmpty)
                            ? 0
                            : MediaQuery.of(context).size.height * .07,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller
                            .SubCategoryList.value.subcategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  controller.getProducts(controller
                                      .SubCategoryList
                                      .value
                                      .subcategories[index]
                                      .id);
                                  setState(() {
                                    currentItem = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  //  width: MediaQuery.of(context).size.width * .2,
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                  decoration: BoxDecoration(
                                    color: currentItem == index
                                        ? mainColor
                                        : Color(0xfff0ebfa),
                                    borderRadius: currentItem == index
                                        ? BorderRadius.circular(10)
                                        : BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.SubCategoryList.value
                                          .subcategories[index].name,
                                      style: TextStyle(
                                          fontFamily: 'ca1',
                                          color: currentItem == index
                                              ? Colors.white
                                              : textColor,
                                          fontSize:
                                              currentItem == index ? 17 : 15,
                                          fontWeight: currentItem == index
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Column(
                    children: [
                      //خطا بالتحديث

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GetX<HomeController>(builder: (cont) {
                          if (controller.isLoading.value == true) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            );
                          } else {
                            return RefreshIndicator(
                              color: mainColor,
                              backgroundColor: mainColor.withOpacity(0.05),
                              onRefresh: controller.getallProducts,
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Column(
                                    children: List.generate(
                                        cont.productList.value.items.length,
                                        (index) {
                                      if (index <
                                          cont.productList.value.items.length) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/detail', arguments: [
                                              "${cont.productList.value.items[index].name}",
                                              (cont.productList.value
                                                  .items[index].description),
                                              "${cont.productList.value.items[index].price}",
                                              (cont.productList.value
                                                  .items[index].address),
                                              (cont.productList.value
                                                  .items[index].nameUser),
                                              (cont.productList.value
                                                  .items[index].images),
                                              (cont.productList.value
                                                  .items[index].numberUser),
                                            ]);
                                          },
                                          child: items(
                                            city:
                                                "${cont.productList.value.items[index].address}",
                                            item_id:
                                                "${cont.productList.value.items[index].id}",
                                            item_name:
                                                "${cont.productList.value.items[index].name}",
                                            item_img: cont.productList.value
                                                    .items[index].images.isEmpty
                                                ? ""
                                                : cont.productList.value
                                                    .items[index].images[0].name
                                                    .toString(),
                                            item_description:
                                                "${cont.productList.value.items[index].description}",
                                            create_item_at:
                                                "${cont.productList.value.items[index].createdAt.toString().substring(0, 16)}",
                                          ),
                                        );
                                      } else {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 32.0),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xff5e17eb),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class items extends StatefulWidget {
  late String item_id;
  late String item_name;
  late String item_img;
  late String item_description;
  late String create_item_at;
  late String city;

  items({
    required this.item_id,
    required this.item_name,
    required this.item_img,
    required this.item_description,
    required this.create_item_at,
    required this.city,
  });

  @override
  State<items> createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  Widget build(BuildContext context) {
    String date = "";
    int d = DateTime.now()
        .difference(DateTime.parse(widget.create_item_at))
        .inHours;
    if (d < 24) {
      date = "ساعة ${d.toString()}";
    } else {
      d = DateTime.now()
          .difference(DateTime.parse(widget.create_item_at))
          .inDays;
      if (d < 31) {
        date = "يوم ${d.toString()}";
      } else {
        if (d < 365) {
          date = "شهر ${(d / 30).round().toString()}";
        } else {
          date = "سنة ${(d / 365).round().toString()}";
        }
      }
    }
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                            widget.item_description.length < 3
                                ? widget.item_description
                                : "${widget.item_description.substring(0, 2)}...",
                            style: TextStyle(
                                fontFamily: 'ca1',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: textColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget.city,
                                    style: TextStyle(
                                        fontFamily: 'ca1',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: textColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
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
                                    date,
                                    style: TextStyle(
                                        fontFamily: 'ca1',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: textColor),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'تفاصيل',
                                      style: TextStyle(
                                          fontFamily: 'ca1',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 110,
                      width: 120,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.teal[50],
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${Uri.parse('${ServerConfig.DNS}/items/${widget.item_img}')}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
