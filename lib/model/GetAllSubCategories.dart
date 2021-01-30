
// To parse this JSON data, do
//
//     final getAllSubCategories = getAllSubCategoriesFromJson(jsonString);

import 'dart:convert';

GetAllSubCategories getAllSubCategoriesFromJson(String str) => GetAllSubCategories.fromJson(json.decode(str));

String getAllSubCategoriesToJson(GetAllSubCategories data) => json.encode(data.toJson());

class GetAllSubCategories {
  GetAllSubCategories({
    this.status,
    this.data,
    this.message,
  });

  String status;
  List<Datum> data;
  String message;

  factory GetAllSubCategories.fromJson(Map<String, dynamic> json) => GetAllSubCategories(
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
    this.subCategoryName,
    this.subCategoryImage,
    this.categoryId,
    this.created,
    this.modified,
    this.musicCount,
    this.musicData,
  });

  String id;
  String subCategoryName;
  String subCategoryImage;
  String categoryId;
  DateTime created;
  DateTime modified;
  int musicCount;
  List<MusicDatum> musicData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    subCategoryName: json["sub_category_name"] == null ? null : json["sub_category_name"],
    subCategoryImage: json["sub_category_image"] == null ? null : json["sub_category_image"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"] == null ? null : DateTime.parse(json["modified"]),
    musicCount: json["music_count"] == null ? null : json["music_count"],
    musicData: json["music_data"] == null ? null : List<MusicDatum>.from(json["music_data"].map((x) => MusicDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sub_category_name": subCategoryName == null ? null : subCategoryName,
    "sub_category_image": subCategoryImage == null ? null : subCategoryImage,
    "category_id": categoryId == null ? null : categoryId,
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
//     final getAllSubCategories = getAllSubCategoriesFromJson(jsonString);

import 'dart:convert';

List<GetAllSubCategories> getAllSubCategoriesFromJson(String str) => List<GetAllSubCategories>.from(json.decode(str).map((x) => GetAllSubCategories.fromJson(x)));

String getAllSubCategoriesToJson(List<GetAllSubCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllSubCategories {
  GetAllSubCategories({
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

  factory GetAllSubCategories.fromJson(Map<String, dynamic> json) => GetAllSubCategories(
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
*/
