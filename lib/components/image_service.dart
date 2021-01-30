import 'dart:async';

import '../model/colllection_list_model.dart';
import '../model/images_list_model.dart';
import 'package:http/http.dart' as http;

Future<ImagesListModel> getImages({String type}) async {
  final res = await http.get(
      'https://api.unsplash.com//search/photos/?client_id=3b1df5538a261c90edc00b184736b38859226d215482386c9b3fc00c5ec094a2&query=$type');

  if (res.statusCode == 200) {
    print(res.body);
    return imagesListModelFromJson(res.body);
  } else
    return null;
}

Future<List<CollectionListModel>> getCollection() async {
  final res = await http.get(
      'https://api.unsplash.com/collections/featured?page=1&client_id=3b1df5538a261c90edc00b184736b38859226d215482386c9b3fc00c5ec094a2');

  if (res.statusCode == 200) {
    print(res.body);
    return collectionListModelFromJson(res.body);
  } else
    return null;
}
