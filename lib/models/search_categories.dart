// To parse this JSON data, do
//
//     final searchCategories = searchCategoriesFromJson(jsonString);

import 'dart:convert';

import 'category_model.dart';

SearchCategories searchCategoriesFromJson(String str) => SearchCategories.fromJson(json.decode(str));

String searchCategoriesToJson(SearchCategories data) => json.encode(data.toJson());

class SearchCategories {
  List<Category> mainCategory;

  SearchCategories({
    required this.mainCategory,
  });

  factory SearchCategories.fromJson(Map<String, dynamic> json) => SearchCategories(
    mainCategory: List<Category>.from(json["Main_category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Main_category": List<dynamic>.from(mainCategory.map((x) => x.toJson())),
  };
}

class MainCategory {
  int id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  MainCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
