import 'package:beezar/models/category_model.dart';
import 'package:http/http.dart' as http;
import '../../../config/server_config.dart';
import '../../../models/products.dart';
import '../../../models/search_categories.dart';
import '../../../models/subCategory_model.dart';

class HomeService {
  Future<Categories> getCategory() async {
    var response =
        await http.get(Uri.parse(ServerConfig.DNS + ServerConfig.category));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return categoriesFromJson(jsonData);
    } else {
      return throw Exception('Error to load category');
    }
  }

  Future<SubCategory> getSubCategory(int id) async {
    var response = await http
        .get(Uri.parse(ServerConfig.DNS + ServerConfig.sub_categ + '${id}'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return subCategoryFromJson(jsonData);
    } else {
      return SubCategory(subcategories: []);
    }
  }

  Future<Product> getProducts(int id) async {
    var response = await http
        .get(Uri.parse(ServerConfig.DNS + ServerConfig.GetProducts + '${id}'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productFromJson(jsonData);
    } else {
      return throw Exception('Error to load category');
    }
  }

  Future<Product> Search(String? name) async {
    if (name == null || name.isEmpty) {
      return await getAllProducts();
    }
    var response = await http.get(
      Uri.parse("${ServerConfig.DNS}${ServerConfig.Search}$name"),
      headers: {
        //'Accept':'application/json',
        //'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiOTZjYWFjYmQ2OGRjN2NkNzgzOTVkYTE3NTAwZTAzNjliZDBlYzBhNzIwNDRiZDA4MTk1MTQwODIwZTlhMGVmY2M5MTcyMTIzNzAxZWYzNzkiLCJpYXQiOjE2NTc1Mzk5MjUuMjQ2NDU1LCJuYmYiOjE2NTc1Mzk5MjUuMjQ2NDYzLCJleHAiOjE2ODkwNzU5MjQuODQ2MTg1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.sBDwFKj61SdyPlW0j3Fw8JigaczTZHmv1-rWzFOeoWnIGCpzmR1hGacvSgsOPoz4UtXRAfp_zVHXtD3xDxWz4eLmZaHspyxrdVpI7e-DJQLhsOtKJ3sPmwedgtlDB3jeDOMLwFAjU14GsSKJZheLhzzTDEffqTCWDDsgzj6zRuUX5JvuUHX0031VyEEjNXzBsAEKFDk0olMQrD7sdIqsKc-VC9Lp_choz1A48FeGeAKDD96cUWAPRXvX2OuDkRQUfB7vTba8cBO0e5hNU4yzVG3vS999FyFlpNjnz2GwUIggJWnPYIvRJln-D1ayCGqZEasFuvYOIUwWzd-HnF9TxTnnsUZ8VHTJFeit6XTR0rPkDk73gQ2iTYwc6HfZdK7-BXghmmOtkLDgMUDhB465OOw0kjEJKP3yLMOi1ehuA3h4Yns4CwsiuVc_WnEvBywhMDTs3F2R99ifSOI_WxljHuk3FaQzamvLElUxWUQkd6qWaHF03OcUdJ0Tazhs9Y-RD8XSnlmWVSsCn4FctYXt7EEFl9Bef7F2hyitUGZLzkttly2UyqA73P_f4Hg2FpkRhC3x9F8gx0HHlzSMghKyowD9dlJ44iVvFWhF5lv-lQ-VYeuw3bVDs11cCu6IPVcvz703dGEl2HhogssAEfNFHGBVftwi4lxy5ofziPUHUEk'
        //'Authorization':'Bearer ${UserInfo.usertoken}'
      },
    );
    if (response.statusCode == 200) {
      var SearchResponse = productFromJson(response.body);
      return SearchResponse;
    } else {
      var SearchResponse = searchCategoriesFromJson(response.body);
      return Product(items: []);
    }
  }

  Future<Product> getAllProducts() async {
    var response = await http
        .get(Uri.parse(ServerConfig.DNS + ServerConfig.GetAllProducts));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productFromJson(jsonData);
    } else {
      return throw Exception('Error to load category');
    }
  }
}
