
// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

MusicModel musicModelFromJson(String str) => MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

class MusicModel {
  MusicModel({
    this.status,
    this.data,
    this.message,
  });

  String status;
  List<Datum> data;
  String message;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

List<MusicModel> musicModelFromJson(String str) => List<MusicModel>.from(json.decode(str).map((x) => MusicModel.fromJson(x)));

String musicModelToJson(List<MusicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MusicModel {
  MusicModel({
    this.musicId,
    this.musicTitle,
    this.musicFile,
    this.musicImage,
    this.categoryId,
    this.subCategoryId,
    this.subCatTagId,
    this.musicSize,
    this.musicDuration,
    this.musicStatus,
    this.createdDate,
    this.isLiked,
    this.isInPlaylist,
  });

  String musicId;
  String musicTitle;
  String musicFile;
  String musicImage;
  String categoryId;
  String subCategoryId;
  String subCatTagId;
  String musicSize;
  String musicDuration;
  String musicStatus;
  DateTime createdDate;
  int isLiked;
  int isInPlaylist;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    musicId: json["music_id"] == null ? null : json["music_id"],
    musicTitle: json["music_title"] == null ? null : json["music_title"],
    musicFile: json["music_file"] == null ? null : json["music_file"],
    musicImage: json["music_image"] == null ? null : json["music_image"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    subCatTagId: json["sub_cat_tag_id"] == null ? null : json["sub_cat_tag_id"],
    musicSize: json["music_size"] == null ? null : json["music_size"],
    musicDuration: json["music_duration"] == null ? null : json["music_duration"],
    musicStatus: json["music_status"] == null ? null : json["music_status"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    isLiked: json["is_liked"] == null ? null : json["is_liked"],
    isInPlaylist: json["is_in_playlist"] == null ? null : json["is_in_playlist"],
  );

  Map<String, dynamic> toJson() => {
    "music_id": musicId == null ? null : musicId,
    "music_title": musicTitle == null ? null : musicTitle,
    "music_file": musicFile == null ? null : musicFile,
    "music_image": musicImage == null ? null : musicImage,
    "category_id": categoryId == null ? null : categoryId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "sub_cat_tag_id": subCatTagId == null ? null : subCatTagId,
    "music_size": musicSize == null ? null : musicSize,
    "music_duration": musicDuration == null ? null : musicDuration,
    "music_status": musicStatus == null ? null : musicStatus,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "is_liked": isLiked == null ? null : isLiked,
    "is_in_playlist": isInPlaylist == null ? null : isInPlaylist,
  };
}
*/
