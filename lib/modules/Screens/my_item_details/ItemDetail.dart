import 'package:beezar/components/custom_btn.dart';
import 'package:beezar/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'item_details_controller.dart';
import 'package:beezar/config/server_config.dart';
class MyItemDetail extends StatefulWidget {
  @override
  State<MyItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<MyItemDetail> {
  MyItemDetailsController controller =Get.find();
  Widget myHeader(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  spreadRadius:1,
                  blurRadius: 2,
                  offset: Offset(0,2),
                )],
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back, color: itemColor,))),
          const Expanded(child: Text("")),
          //..............shop card
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  spreadRadius:1,
                  blurRadius: 1,
                  offset: Offset(0,1),
                )],
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(onPressed: (){
                FlutterShare.share(title: "مشاركة الاعلان");
              }, icon: Icon(Icons.share, color: itemColor,))),
        ],
      ),
    );
  }
  Widget mealImage(){
    return Container(

      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0,2),
          color: Colors.grey,
        ),],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.27,
            width:MediaQuery.of(context).size.width           ,
            child: AnotherCarousel(images: List.generate(controller.image.length, (index) => GestureDetector(
                onTap: (){
                  Get.toNamed('/imageViewer',arguments: ServerConfig.DNS+'/'+controller.image[index].path+'/'+controller.image[index].name);
                },

            child: CachedNetworkImage(
              imageUrl:"${Uri.parse("${Uri.parse(ServerConfig.DNS+'/'+controller.image[index].path+'/'+controller.image[index].name)}")}",
              placeholder: (context,url)=> const CircularProgressIndicator(color: Color(0xff5e17eb),),
              imageBuilder: (context,imageProvider){
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill
                      )
                  ),
                );
              },
            ),
            )
),),
          ),
//           (controller.image != [])? Image.network("${Uri.parse("${ServerConfig.DNSlocal}/${controller.image[0].path}/${controller.image[0].name}")}")
// :Container(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(controller.userName,style: TextStyle(color: textColor,fontSize: 13)),
              Row(
                children: [
                  Icon(Icons.phone,color: mainColor,),
                  Text(controller.userNumber,style: TextStyle(color: textColor,fontSize: 13)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on_rounded,color: mainColor,),
                  Text(controller.address,style: TextStyle(color: textColor,fontSize: 13)),

                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    spreadRadius:1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15),
                ),


                ),


            ],
          ),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
          children: [
            ListView(
              children: [

                mealImage(),

                Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.name, style: TextStyle(fontSize: 30, fontFamily: 'ca1', fontWeight: FontWeight.bold, color: textColor),),

                        Text(controller.des, style: TextStyle(fontSize: 16, fontFamily: 'ca1', color: textColor),),
                        Text('السعر',style: TextStyle(fontSize: 25, fontFamily: 'ca1', color: textColor), ),
                        Text(controller.price,style: TextStyle(fontSize: 25, fontFamily: 'ca1', color: textColor), )
                      ],
                    )),
                CustomBtn(onTapBtn: (){
                  Get.back();
                }, btnBgColor: mainColor,btnText: 'عودة للصفحة السابقة',btnTxtColor: Colors.white,),

              ],
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 120.0,
              child: myHeader(),),
          ]
      ),

    ),

    );
  }
}
