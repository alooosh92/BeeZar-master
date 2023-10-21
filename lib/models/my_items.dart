// To parse this JSON data, do
//
//     final myItems = myItemsFromJson(jsonString);

import 'dart:convert';

MyItems myItemsFromJson(String str) => MyItems.fromJson(json.decode(str));

String myItemsToJson(MyItems data) => json.encode(data.toJson());

class MyItems {
  List<Item> items;

  MyItems({
    required this.items,
  });

  factory MyItems.fromJson(Map<String, dynamic> json) => MyItems(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  String name;
  String description;
  int price;
  String address;
  String numberUser;
  String nameUser;
  int userId;
  int categoryId;
  int subCategoryId;
  dynamic createdAt;
  dynamic updatedAt;
  List<ImageI> images;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.numberUser,
    required this.nameUser,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        address: json["address"],
        numberUser: json["number_user"],
        nameUser: json["name_user"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        images:
            List<ImageI>.from(json["images"].map((x) => ImageI.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "address": address,
        "number_user": numberUser,
        "name_user": nameUser,
        "user_id": userId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageI {
  int id;
  String name;
  int itemId;
  String path;
  dynamic createdAt;
  dynamic updatedAt;

  ImageI({
    required this.id,
    required this.name,
    required this.itemId,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageI.fromJson(Map<String, dynamic> json) => ImageI(
        id: json["id"],
        name: json["name"],
        itemId: json["item_id"],
        path: json["path"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "item_id": itemId,
        "path": path,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
