// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  List<Item> items;

  Product({
    required this.items,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
  var createdAt;
  var updatedAt;
  List<ImageProdect> images;

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
        createdAt: (json["created_at"] != null)
            ? DateTime.parse(json["created_at"])
            : "لا يوجد",
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : "لا يوجد",
        images: List<ImageProdect>.from(
            json["images"].map((x) => ImageProdect.fromJson(x))),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageProdect {
  int id;
  String name;
  int itemId;
  String path;

  ImageProdect({
    required this.id,
    required this.name,
    required this.itemId,
    required this.path,
  });

  factory ImageProdect.fromJson(Map<String, dynamic> json) => ImageProdect(
        id: json["id"],
        name: json["name"],
        itemId: json["item_id"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "item_id": itemId,
        "path": path,
      };
}
