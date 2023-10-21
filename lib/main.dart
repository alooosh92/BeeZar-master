import 'package:beezar/Middleware/AuthMiddleware.dart';
import 'package:beezar/constants.dart';
import 'package:beezar/getx_bindings/add_product_binding.dart';
import 'package:beezar/getx_bindings/binding.dart';
import 'package:beezar/getx_bindings/category_binding.dart';
import 'package:beezar/getx_bindings/choose_subcat_binding.dart';
import 'package:beezar/getx_bindings/home_binding.dart';
import 'package:beezar/getx_bindings/image_viewer_binding.dart';
import 'package:beezar/getx_bindings/item_binding.dart';
import 'package:beezar/getx_bindings/my_products_binding.dart';
import 'package:beezar/getx_bindings/myitemdetails_binding.dart';
import 'package:beezar/getx_bindings/splash_binding.dart';
import 'package:beezar/getx_bindings/subcategory_binding.dart';
import 'package:beezar/modules/Screens/add_product/add_product.dart';
import 'package:beezar/modules/Screens/choose_subcategory/sub_category.dart';
import 'package:beezar/modules/Screens/image_viewer/image_viewer.dart';
import 'package:beezar/modules/Screens/my_item_details/ItemDetail.dart';
import 'package:beezar/modules/Screens/my_products/my_products_screen.dart';
import 'package:beezar/modules/Screens/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'getx_bindings/products_binding.dart';
import 'modules/Screens/home/homePage.dart';
import 'modules/Screens/item_details/ItemDetail.dart';
import 'modules/Screens/products/products_screen.dart';
import 'modules/Screens/splash/splashScreen.dart';
import 'modules/Screens/subCategory/sub_category.dart';
import 'modules/Screens/chooseNb.dart';
import 'modules/login/login.dart';
import 'modules/signup/Usage policy.dart';
import 'modules/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
//import 'package:google_fonts/google_fonts.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

SharedPreferences? sharedPrefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingDef(),
      theme: ThemeData(
        fontFamily: "Cairo",
        primaryColor: mainColor,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(
            name: '/start',
            page: () => StartPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/choose',
            page: () => chooseNavicationBar(),
            binding: CategoryBinding()),
        GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
        GetPage(name: '/login', page: () => LogIn()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(
            name: '/subcategory',
            page: () => SubCategoryPage(),
            binding: SubCategoryBinding()),
        GetPage(
            name: '/detail', page: () => ItemDetail(), binding: ItemBinding()),
        GetPage(
            name: '/mydetail',
            page: () => MyItemDetail(),
            binding: MyItemDetailsBinding()),
        GetPage(
            name: '/imageViewer',
            page: () => ImageViewer(),
            binding: ImageViewerBinding()),
        GetPage(
            name: '/choose_sub_category',
            page: () => ChooseSubCategoryPage(),
            binding: ChooseSubCategoryBinding()),
        GetPage(
            name: '/add_item',
            page: () => AddItem(),
            binding: AddProductBinding()),
        GetPage(
            name: '/products',
            page: () => ProductsScreen(),
            binding: ProductBinding()),
        GetPage(
            name: '/my_items',
            page: () => MyProductsScreen(),
            binding: MyItemBinding()),
        GetPage(name: '/policy', page: () => UsagePolicy()),
        GetPage(
            name: '/splash', page: () => Splash(), binding: SplashBinding()),
        GetPage(name: '/hooome', page: () => HomePage()),
      ],
      builder: EasyLoading.init(),
    );
  }
}
