import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  late final String id;
  late final String recipeName;
  late final String displayName;
  late final int cateId;
  late final bool isFav;
  late final int favNum;
  late final List<RecipeDetail> detailList;
  late final List<String> imageList;

  @override
  List<Object> get props => [id, recipeName];

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    recipeName = json["recipeName"];
    displayName = json["displayName"];
    cateId = json["cateId"];
    isFav = json["isFav"];
    favNum = json["favNum"];
    detailList = json["detailList"];
    imageList = json["imageList"];
  }

  // Map data from QueryDocumentSnapshot
  Recipe.fromQuerySnapshot({
    required QueryDocumentSnapshot<Map<String, dynamic>> recipeSnap,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> detailSnapList,
    required bool isFav,
  }) {
    final data = recipeSnap.data();
    id = recipeSnap.id;
    recipeName = data["recipeName"];
    displayName = data["displayName"];
    cateId = data["cateId"];
    isFav = isFav;
    favNum = data["favNum"];
    imageList =
        (data["imageList"] as List<dynamic>).map<String>((e) => e).toList();
    detailList =
        detailSnapList.map((e) => RecipeDetail.fromSnapshot(e)).toList();
  }

  // Map data from DocumentSnapshot
  Recipe.fromSnapshot({
    required DocumentSnapshot<Map<String, dynamic>> recipeSnap,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> detailSnapList,
    required bool isFav,
  }) {
    final data = recipeSnap.data();
    id = recipeSnap.id;
    if (data != null) {
      recipeName = data["recipeName"];
      displayName = data["displayName"];
      cateId = data["cateId"];
      isFav = isFav;
      favNum = data["favNum"];
      imageList =
          (data["imageList"] as List<dynamic>).map<String>((e) => e).toList();
      detailList =
          detailSnapList.map((e) => RecipeDetail.fromSnapshot(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["recipeName"] = recipeName;
    map["displayName"] = displayName;
    map["cateId"] = cateId;
    map["favNum"] = favNum;
    map["detailList"] = detailList;
    map["imageList"] = imageList;
    return map;
  }
}

class RecipeDetail {
  late int _index;
  late String _description;

  RecipeDetail({
    required int index,
    required String description,
  })  : _index = index,
        _description = description;

  int get index => _index;
  String get description => _description;

  RecipeDetail.fromJson(dynamic json) {
    _index = json["index"];
    _description = json["description"];
  }

  RecipeDetail.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    _index = int.parse(snap.id);
    _description = data["description"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["index"] = _index;
    map["description"] = _description;
    return map;
  }
}
