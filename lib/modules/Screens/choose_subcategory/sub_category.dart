import 'package:beezar/constants.dart';
import 'package:beezar/models/subCategory_model.dart';
import 'package:beezar/modules/Screens/choose_subcategory/sub_category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../config/server_config.dart';
import '../../Drawer/drawer.dart';

class ChooseSubCategoryPage extends StatefulWidget {


  @override
  State<ChooseSubCategoryPage> createState() => _homePageState();
}

class _homePageState extends State<ChooseSubCategoryPage> {
  TextEditingController srch = TextEditingController();
  ChooseSubCategoryController controller = Get.find();



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
                    ),),
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
                ListView(
                  children: [
                    Text(
                      'اختر التصنيف الثاني',
                      style: TextStyle(
                          fontSize: 30,
                          color: mainColor,
                          fontFamily: 'ca1'),
                    ),
                    const SizedBox(height: 10,),
                    GridView.builder(
                      itemCount:controller.CategoryList.value.subcategories.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: (){
                            Get.toNamed('/add_item',arguments: [controller.CategoryList.value.subcategories[index].id,
                              controller.CategoryList.value.subcategories[index].name,
                              controller.id,
                            ]);
                          },
                          child: Card(
                            elevation: 30,
                            child: Column(
                                children: [
                                  Center(
                                      child:Text(controller.CategoryList.value.subcategories[index].name,
                                        style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 20,fontFamily: 'ca1'),)),
                                  SizedBox(height: 10,),
                                  ClipRRect(
                                    child:
                                    Container(

                                        height: MediaQuery.of(context).size.height*0.15,
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
                  ],
                ),
              ]
          );

        }) ));
  }
}