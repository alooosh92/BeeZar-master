import 'package:beezar/models/category_model.dart';
import 'package:beezar/modules/Screens/category/category_service.dart';
import 'package:get/get.dart';

import '../../../models/products.dart';
import '../../../models/subCategory_model.dart';
import 'home_service.dart';

class HomeController extends GetxController {
  HomeService service = HomeService();
  var CategoryList = Categories(categories: []).obs;
  var SubCategoryList = SubCategory(subcategories: []).obs;
  var productList = Product(items: []).obs;
  var productList2 = Product(items: []).obs;
  var isLoading = true.obs;
  var id = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    CategoryList.value = await service.getCategory();
    productList2.value = await service.getAllProducts();
    productList.value.items = productList2.value.items;
    isLoading.value = false;
  }

  Future<void> ChangeId(int newID) async {
    id.value = newID;
    SubCategoryList.value = await service.getSubCategory(newID);
  }

  Future<void> Search(String str) async {
    if (str == null || str.isNotEmpty) {
      productList.value.items = productList2.value.items
          .where((element) => element.name.contains(str))
          .toList();
      productList.refresh();
    } else {
      productList.value.items = productList2.value.items;
      productList.refresh();
    }
  }

  Future<void> getProducts(int str) async {
    productList.value = await service.getProducts(str);
    productList.refresh();
  }

  Future<void> getallProducts() async {
    productList.value = await service.getAllProducts();
    productList.refresh();
    print("Done");
  }
}
