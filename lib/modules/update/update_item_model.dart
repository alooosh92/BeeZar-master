import 'dart:io';

class UpdateItemModel {
  late String id;
  late String name;
  late String description;
  late int categoryId;
  late int subCategoryId;
  late List<File>? file;
  late double price;
  late String address;

  UpdateItemModel(
      {required this.categoryId,
      required this.description,
      this.file,
      required this.id,
      required this.name,
      required this.subCategoryId,
      required this.price,
      required this.address});
}
