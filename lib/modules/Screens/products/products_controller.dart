import 'package:beezar/models/category_model.dart';
import 'package:beezar/models/products.dart';
import 'package:beezar/modules/Screens/category/category_service.dart';
import 'package:beezar/modules/Screens/products/products_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ProductController extends GetxController {
  ProductsService service = ProductsService();
  var productList =Product(items: []).obs ;
  var isLoading = true.obs;
  var id;
  @override
  void onInit()async{
    super.onInit();

    id =Get.arguments;
  }
  @override
  void onReady() async{
    print("let go");
    await getProducts(id);
    print("end");
    isLoading.value=false;
    super.onReady();
  }
  Future<void> Search(String str)async{
    productList.value=await service.Search(str);
  }
  Future<void> getProducts(int str)async{
    productList.value = await service.getProducts(str);
  }

}
