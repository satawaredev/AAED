// To parse this JSON data, do
//
//     final tagSubCatModel = tagSubCatModelFromJson(jsonString);

import 'dart:convert';

TagSubCatModel tagSubCatModelFromJson(String str) => TagSubCatModel.fromJson(json.decode(str));

String tagSubCatModelToJson(TagSubCatModel data) => json.encode(data.toJson());

class TagSubCatModel {
  TagSubCatModel({
    this.status,
    this.data,
    this.message,
  });

  String status;
  List<Datum> data;
  String message;

  factory TagSubCatModel.fromJson(Map<String, dynamic> json) => TagSubCatModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message == null ? null : message,
  };
}

class Datum {
  Datum({
    this.id,
    this.tagName,
    this.tagFile,
    this.subCategoryId,
    this.created,
    this.modified,
    this.musicCount,
    this.musicData,
  });

  String id;
  String tagName;
  String tagFile;
  String subCategoryId;
  DateTime created;
  DateTime modified;
  int musicCount;
  List<MusicDatum> musicData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    tagName: json["tag_name"] == null ? null : json["tag_name"],
    tagFile: json["tag_file"] == null ? null : json["tag_file"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"] == null ? null : DateTime.parse(json["modified"]),
    musicCount: json["music_count"] == null ? null : json["music_count"],
    musicData: json["music_data"] == null ? null : List<MusicDatum>.from(json["music_data"].map((x) => MusicDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "tag_name": tagName == null ? null : tagName,
    "tag_file": tagFile == null ? null : tagFile,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "created": created == null ? null : created.toIso8601String(),
    "modified": modified == null ? null : modified.toIso8601String(),
    "music_count": musicCount == null ? null : musicCount,
    "music_data": musicData == null ? null : List<dynamic>.from(musicData.map((x) => x.toJson())),
  };
}

class MusicDatum {
  MusicDatum({
    this.id,
    this.musicName,
    this.musicImage,
    this.musicFile,
    this.musicType,
    this.categoryId,
    this.subCategoryId,
    this.tagId,
    this.status,
    this.created,
    this.modified,
  });

  String id;
  String musicName;
  String musicImage;
  String musicFile;
  String musicType;
  String categoryId;
  String subCategoryId;
  String tagId;
  String status;
  DateTime created;
  DateTime modified;

  factory MusicDatum.fromJson(Map<String, dynamic> json) => MusicDatum(
    id: json["id"] == null ? null : json["id"],
    musicName: json["music_name"] == null ? null : json["music_name"],
    musicImage: json["music_image"] == null ? null : json["music_image"],
    musicFile: json["music_file"] == null ? null : json["music_file"],
    musicType: json["music_type"] == null ? null : json["music_type"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    tagId: json["tag_id"] == null ? null : json["tag_id"],
    status: json["status"] == null ? null : json["status"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"] == null ? null : DateTime.parse(json["modified"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "music_name": musicName == null ? null : musicName,
    "music_image": musicImage == null ? null : musicImage,
    "music_file": musicFile == null ? null : musicFile,
    "music_type": musicType == null ? null : musicType,
    "category_id": categoryId == null ? null : categoryId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "tag_id": tagId == null ? null : tagId,
    "status": status == null ? null : status,
    "created": created == null ? null : created.toIso8601String(),
    "modified": modified == null ? null : modified.toIso8601String(),
  };
}


/*
// To parse this JSON data, do
//
//     final tagSubCatModel = tagSubCatModelFromJson(jsonString);

import 'dart:convert';

TagSubCatModel tagSubCatModelFromJson(String str) => TagSubCatModel.fromJson(json.decode(str));

String tagSubCatModelToJson(TagSubCatModel data) => json.encode(data.toJson());

class TagSubCatModel {
  TagSubCatModel({
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

  factory TagSubCatModel.fromJson(Map<String, dynamic> json) => TagSubCatModel(
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
*/
