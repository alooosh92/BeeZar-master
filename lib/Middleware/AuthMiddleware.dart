import 'package:beezar/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware{
  @override
RouteSettings? redirect(String? route)  {
      if(sharedPrefs!.getString("id")!=null) {
        return const RouteSettings(name: "/choose");
      }
  }
 }
