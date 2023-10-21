import 'package:beezar/models/category_model.dart';
import 'package:beezar/models/my_items.dart';
import 'package:beezar/models/products.dart';
import 'package:beezar/modules/Screens/category/category_service.dart';
import 'package:beezar/modules/Screens/products/products_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'my_products_service.dart';

class MyProductController extends GetxController {
  MyProductsService service = MyProductsService();
  var productList =MyItems(items: []).obs ;
  var isLoading = true.obs;
  var id;
  var deleteDONE=false.obs;
  @override
  void onInit()async{
    super.onInit();
  }
  @override
  void onReady() async{
    print("let go");
    await getProducts();
    print("end");
    isLoading.value=false;
    super.onReady();
  }
  Future<void> Search(String str)async{
   // productList.value=await service.Search(str);
  }
  Future<void> getProducts()async{
    productList.value = await service.getProducts();
  }
  Future<void> DeleteItem(int id)async {
    deleteDONE.value =await service.DeleteItem(id);
  }

}
