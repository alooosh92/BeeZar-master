import 'package:beezar/models/category_model.dart';
import 'package:beezar/models/subCategory_model.dart';
import 'package:beezar/modules/Screens/choose_subcategory/sub_category_service.dart';
import 'package:beezar/modules/Screens/subCategory/sub_category_service.dart';
import 'package:get/get.dart';

class ChooseSubCategoryController extends GetxController {
  ChooseSubCategoryService service = ChooseSubCategoryService();
  var CategoryList =SubCategory(subcategories:[]).obs ;
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
    CategoryList.value = await service.getSubCategory(id);
    print("end");
    isLoading.value=false;
    super.onReady();
  }
  Future<void> Search(String str)async{
    CategoryList.value=await service.Search(str);
  }

}
