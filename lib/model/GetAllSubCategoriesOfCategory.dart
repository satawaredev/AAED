// To parse this JSON data, do
//
//     final getAllSubCategoriesOfCategory = getAllSubCategoriesOfCategoryFromJson(jsonString);

import 'dart:convert';

List<GetAllSubCategoriesOfCategory> getAllSubCategoriesOfCategoryFromJson(String str) => List<GetAllSubCategoriesOfCategory>.from(json.decode(str).map((x) => GetAllSubCategoriesOfCategory.fromJson(x)));

String getAllSubCategoriesOfCategoryToJson(List<GetAllSubCategoriesOfCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllSubCategoriesOfCategory {
  GetAllSubCategoriesOfCategory({
    this.subCategoryId,
    this.categoryId,
    this.subCategoryName,
    this.subCategoryIcon,
    this.musicCount,
  });

  String subCategoryId;
  String categoryId;
  String subCategoryName;
  String subCategoryIcon;
  int musicCount;

  factory GetAllSubCategoriesOfCategory.fromJson(Map<String, dynamic> json) => GetAllSubCategoriesOfCategory(
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    subCategoryName: json["sub_category_name"] == null ? null : json["sub_category_name"],
    subCategoryIcon: json["sub_category_icon"] == null ? null : json["sub_category_icon"],
    musicCount: json["music_count"] == null ? null : json["music_count"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "category_id": categoryId == null ? null : categoryId,
    "sub_category_name": subCategoryName == null ? null : subCategoryName,
    "sub_category_icon": subCategoryIcon == null ? null : subCategoryIcon,
    "music_count": musicCount == null ? null : musicCount,
  };
}
