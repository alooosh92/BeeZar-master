import 'package:beezar/config/server_config.dart';
import 'package:beezar/modules/Screens/products/products_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../components/custom_btn.dart';
import '../../../constants.dart';


class ProductsScreen extends StatelessWidget {

  TextEditingController srch = TextEditingController();
  ProductController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
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
              onChanged: (
                  value
                  )async{
               if(value==""){
                 controller.getProducts(controller.id);
               }
               else{
                 controller.Search(value);
               }
              },
              controller: srch,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
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

      ),
     // drawer:Drawerr(),
      body: ListView(
          children:[ Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                child: Obx((){
                  if(controller.isLoading.value==true)
                    {
                      return Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      );
                    }
                  else{
                    return ListView(
                      children: [
                        Column(
                          children: List.generate(controller.productList.value.items.length, (index) =>   GestureDetector(
                            onTap: (){
                              Get.toNamed('/detail',arguments: [
                                "${controller.productList.value.items[index].name}",
                                (controller.productList.value.items[index].description),
                                "${controller.productList.value.items[index].price}",
                                (controller.productList.value.items[index].address),
                                (controller.productList.value.items[index].nameUser),
                                (controller.productList.value.items[index].images),
                                (controller.productList.value.items[index].numberUser),

                              ]);
                            },
                            child: items(
                              item_id:"${controller.productList.value.items[index].id}",
                              item_name:"${controller.productList.value.items[index].name}",
                              item_img:"${controller.productList.value.items[index].images[0].path}",
                              item_description:"${controller.productList.value.items[index].description}",
                              create_item_at:"${controller.productList.value.items[index].createdAt}",
                            ),
                          ),),
                        ),
                        SizedBox(height: 100,),
                      ],
                    );
                  }
                }),
              ),
              CustomBtn(onTapBtn: (){
                Get.offNamed('/choose');
              }, btnBgColor: mainColor,btnText: 'عودة للصفحة الرئيسية',btnTxtColor: Colors.white,),
            ],
          ),
          ]
      ),

    ));
  }

}
class items extends StatefulWidget {
  late String item_id;
  late String item_name;
  late String item_img;
  late String item_description;
  late String create_item_at;


  items({
    required this.item_id,
    required this.item_name,
    required this.item_img,
    required this.item_description,
    required this.create_item_at,
  });

  @override
  State<items> createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.01,
          right: MediaQuery.of(context).size.width * 0.01,
          bottom: MediaQuery.of(context).size.width *0.01
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 2.0
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                      child: Column(
                        children: [
                          Text(
                            widget.item_name,
                            style: TextStyle(fontFamily: 'ca1', fontWeight: FontWeight.bold,fontSize:20,color: mainColor,),
                          ),
                          Text(
                            "${widget.item_description.substring(0,4)}...",
                            style: TextStyle(fontFamily: 'ca1', fontWeight: FontWeight.bold,fontSize:15,color: textColor),
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time_sharp, size: 15,),
                              SizedBox(width: 2,),
                              Text(
                                widget.create_item_at,
                                style: TextStyle(fontFamily: 'ca1', fontWeight: FontWeight.bold,fontSize:10,color: textColor),
                              ),
                              TextButton(onPressed: (){

                              }, child: Text('تفاصيل',
                                style: TextStyle(fontFamily: 'ca1', fontWeight: FontWeight.bold,fontSize:15,color: mainColor),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                      },
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
                        child: ClipRRect(
                          child: Image.network("${Uri.parse("https://beezar.arg-tr.com/public/${widget.item_img}")}"),
                        )
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
