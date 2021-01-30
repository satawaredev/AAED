// To parse this JSON data, do
//
//     final getAllSubCategoriesOfCategory = getAllSubCategoriesOfCategoryFromJson(jsonString);

import 'dart:convert';

List<GetAllCategory> getAllCategoryFromJson(String str) => List<GetAllCategory>.from(json.decode(str).map((x) => GetAllCategory.fromJson(x)));

String getAllCategoryToJson(List<GetAllCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCategory {
  GetAllCategory({
    this.Id,
    this.CategoryName,
    this.CategoryIcon,
    this.musicCount,
  });

  String Id;
  String CategoryName;
  String CategoryIcon;
  int musicCount;

  factory GetAllCategory.fromJson(Map<String, dynamic> json) => GetAllCategory(
    Id: json["id"] == null ? null : json["id"],
    CategoryName: json["category_name"] == null ? null : json["category_name"],
    CategoryIcon: json["category_icon"] == null ? null : json["category_icon"],
    musicCount: json["music_count"] == null ? null : json["music_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": Id == null ? null : Id,
    "sub_category_name": CategoryName == null ? null : CategoryName,
    "sub_category_icon": CategoryIcon == null ? null : CategoryIcon,
    "music_count": musicCount == null ? null : musicCount,
  };
}
