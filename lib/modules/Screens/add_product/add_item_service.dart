import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/server_config.dart';

class AddItemService {
  var url = Uri.parse(ServerConfig.DNS + ServerConfig.AddItem);

  Future<bool> AddItem(var name, var des, var price, var address,
      List<File> images, var subCatID, var Catid) async {
    final sp = await SharedPreferences.getInstance();
    var request = new http.MultipartRequest("POST", url);
    request.headers.addAll({
      'Authorization': 'Bearer ${sp.getString('id')}',
    });
    List<http.MultipartFile> files = [];
    for (File file in images) {
      var f = await http.MultipartFile.fromPath('files[]', file.path);
      files.add(f);
    }
    request.files.addAll(files);

    request.fields['name'] = name;
    request.fields['description'] = des;
    request.fields['category_id'] = "$Catid";
    request.fields['price'] = "$price";
    request.fields['address'] = address;
    request.fields['sub_category_id'] = "$subCatID";

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
