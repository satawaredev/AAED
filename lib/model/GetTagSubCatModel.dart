// To parse this JSON data, do
//
//     final getTagSubCatModel = getTagSubCatModelFromJson(jsonString);

import 'dart:convert';

GetTagSubCatModel getTagSubCatModelFromJson(String str) => GetTagSubCatModel.fromJson(json.decode(str));

String getTagSubCatModelToJson(GetTagSubCatModel data) => json.encode(data.toJson());

class GetTagSubCatModel {
  GetTagSubCatModel({
    this.subCatTagId,
    this.subCategoryId,
    this.subCatTagName,
    this.subCatTagIcon,
    this.musicCount,
  });

  String subCatTagId;
  String subCategoryId;
  String subCatTagName;
  String subCatTagIcon;
  int musicCount;

  factory GetTagSubCatModel.fromJson(Map<String, dynamic> json) => GetTagSubCatModel(
    subCatTagId: json["sub_cat_tag_id"] == null ? null : json["sub_cat_tag_id"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    subCatTagName: json["sub_cat_tag_name"] == null ? null : json["sub_cat_tag_name"],
    subCatTagIcon: json["sub_cat_tag_icon"] == null ? null : json["sub_cat_tag_icon"],
    musicCount: json["music_count"] == null ? null : json["music_count"],
  );

  Map<String, dynamic> toJson() => {
    "sub_cat_tag_id": subCatTagId == null ? null : subCatTagId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "sub_cat_tag_name": subCatTagName == null ? null : subCatTagName,
    "sub_cat_tag_icon": subCatTagIcon == null ? null : subCatTagIcon,
    "music_count": musicCount == null ? null : musicCount,
  };
}
