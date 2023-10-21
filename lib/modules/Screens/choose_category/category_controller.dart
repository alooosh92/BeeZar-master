import 'package:beezar/models/category_model.dart';
import 'package:get/get.dart';

import 'category_service.dart';

class ChooseCategoryController extends GetxController {
  ChooseCategoryService service = ChooseCategoryService();
  var CategoryList =Categories(categories: []).obs ;
  var isLoading = true.obs;

  @override
  void onInit()async{
    super.onInit();

    print("let go");
    CategoryList.value = await service.getCategory();
    print("end");
    isLoading.value=false;
  }
  Future<void> Search(String str)async{
    CategoryList.value=await service.Search(str);
  }

}
