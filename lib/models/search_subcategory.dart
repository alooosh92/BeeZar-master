// To parse this JSON data, do
//
//     final searchSubCategory = searchSubCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:beezar/models/subCategory_model.dart';

SearchSubCategory searchSubCategoryFromJson(String str) => SearchSubCategory.fromJson(json.decode(str));

String searchSubCategoryToJson(SearchSubCategory data) => json.encode(data.toJson());

class SearchSubCategory {
  List<Subcategory> subCategory;

  SearchSubCategory({
    required this.subCategory,
  });

  factory SearchSubCategory.fromJson(Map<String, dynamic> json) => SearchSubCategory(
    subCategory: List<Subcategory>.from(json["sub_category"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory1 {
  int id;
  String name;
  String image;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;

  SubCategory1({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategory1.fromJson(Map<String, dynamic> json) => SubCategory1(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    categoryId: json["category_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "category_id": categoryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
