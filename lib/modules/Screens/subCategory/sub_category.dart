import 'dart:convert';
import 'package:beezar/constants.dart';
import 'package:beezar/main.dart';
import 'package:beezar/models/subCategory_model.dart';
import 'package:beezar/modules/Screens/category/category_controller.dart';
import 'package:beezar/modules/Screens/subCategory/sub_category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../config/server_config.dart';
import '../../Drawer/drawer.dart';
import 'package:http/http.dart' as http;


class SubCategoryPage extends StatefulWidget {


  @override
  State<SubCategoryPage> createState() => _homePageState();
}

class _homePageState extends State<SubCategoryPage> {
  TextEditingController srch = TextEditingController();
  SubCategoryController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl, child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Padding(
            padding:  EdgeInsets.only(right:1.0),
            child: Container(
              height: 40,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                onChanged: (value){
                  controller.Search(value);
                },
                controller: srch,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color:Colors.black,
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
          actions: [
            IconButton(onPressed: (){Get.back();
              controller.CategoryList.value=SubCategory(subcategories: []);
              }, icon: Icon(Icons.arrow_back_ios_new_rounded),),
          ],
        ),
        drawer:Drawerr(),
        body:  Obx((){
          return (controller.isLoading.value ==true)?Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          ):Stack(
              children: [
                GridView.builder(
                  itemCount:controller.CategoryList.value.subcategories.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: (){
                        Get.toNamed('/products',arguments: controller.CategoryList.value.subcategories[index].id);
                      },
                      child: Card(
                        elevation: 30,
                        child: ListView(
                            children: [
                              Center(
                                  child:Text(controller.CategoryList.value.subcategories[index].name,
                                    style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 15,fontFamily: 'ca1'),)),
                              SizedBox(height:5,),
                              ClipRRect(
                                child:
                                Container(
                                    width: 200,
                                    height: 150,
                                    child:controller.CategoryList.value.subcategories[index].id=="4"?  Image.asset("assets/images/pets.jpg"):
                                    controller.CategoryList.value.subcategories[index].image!="null"?Image.network("${Uri.parse(ServerConfig.DNS+'/public'+'/'+controller.CategoryList.value.subcategories[index].image)}"):   Image.asset("")
                                ),
                              ),
                            ]

                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              ]
          );

        }) ));
  }
}