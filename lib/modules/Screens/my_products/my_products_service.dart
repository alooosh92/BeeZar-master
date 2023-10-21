import 'package:beezar/models/category_model.dart';
import 'package:beezar/models/my_items.dart';
import 'package:beezar/models/products.dart';
import 'package:beezar/models/search_categories.dart';
import 'package:http/http.dart' as http ;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/server_config.dart';

var url =Uri.parse(ServerConfig.DNS + ServerConfig.GetMyItems);
class MyProductsService{
  Future<MyItems> getProducts()async{
    final sp=await SharedPreferences.getInstance();
    var response =  await http.get(url,
      headers: {
        //'Accept':'application/json',

        'Authorization':'Bearer ${ sp.getString('id')}',  },);
    if (response.statusCode == 200){
      var jsonData = response.body;
      print(response.body);
      print(response.statusCode);
      return myItemsFromJson(jsonData);
    }else {
      print(response.body);
      print(response.statusCode);
      return throw Exception('Error to load category');
    }
  }
  Future<bool> DeleteItem(int id) async {
    print("I am here Meals");
    print(id);
    final sp=await SharedPreferences.getInstance();
    var response = await http.delete(

      Uri.parse("${ServerConfig.DNS}${ServerConfig.DeleteItem}/$id"),

      headers: {
        //'Authorization':'Bearer ${ sp.getString('id')}',
        //'Accept':'application/json',
       // 'Authorization':'Bearer ${UserInfo.usertoken}'
        // ,'Authorization':'Bearer ${UserInfo.usertoken}'
       // 'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmY2NGQ1NTRlZjNlN2ZkNjBmNmM5ZGYyNWFmMjBmNWFjODE2NTViNjAwYTZhMGQwYWQ5ZGY1NGVjN2ZlOTRlMjkzMDQ3Zjg3Y2NlOWRhMjIiLCJpYXQiOjE2OTM4NzQ0NDcuMzcyNjI4LCJuYmYiOjE2OTM4NzQ0NDcuMzcyNjQsImV4cCI6MTcyNTQ5Njg0Ni45ODA1MDcsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.KWmQ_EESgdQ4ydBJDjhIR0mryLu5B-4M9LDWQz6id4lKJu4W9Jt-T8Bnr0PEg5xF53S6NY9lG2v1oBCajJ-vMCtnYdWiPLd6a2btwWREFJMyFSUFa8OxMXY1Hjk9zfemdldE6AT_RjzKTUZ4ZdqvlAXU7tyUKi_po5S27CT64VEd31M4crYziRtDfsmTONDDAON5wdSRkVprCDLLDCDd8EtZo5XJuGE3yIuJuT1Twru3s2IHuOM6fHzU03qL2Iq2ZRaIM-1cbPef-15YeRmnBb3PvSz9PmdpYKxg5HFxhgeGyddQWdWuMKwOJ1ULKl3dViXxw_fwe2Nh5Z7mZRs9rb6IL_TwUmkyvooLQjj-NeWHxq94alh7W67F3WLYMBZ7rE7Ts5eo3DK3kL7L3PLYSA9Yjm_3jPW9LR2O2Pb9lUj70pLykhyeYPFCECPhAyiL2vHU9wFHKWp8m5ccccjB3CMLjtmtyxNW04T3mnVFlaMrc8H6PHsD0dkzRXWiHPbRVqP6SWEe3UWLHd4F4R_402wANEJdcuxzhY70PpU6dQiNOfEMu_gRe88A5S8_85ztl94sEJfwJOzA3NjkQDsnaMo9rWUHicWiW_tW-n6uqHCfbYfdFN5HljlZ0q8_fQMeWvTfoVQXJXenZAaGPQaqqWpD18JQB4FkssznqHbj33w'

  },

    );
    if(response.statusCode==200)
    {
     // var WaitResponse = myReservationFromJson(response.body);
      print(response.statusCode);
      print(response.body);
      return true;

    }
    else {print(response.statusCode);
    print(response.body);
    return false;
    }
  }
}