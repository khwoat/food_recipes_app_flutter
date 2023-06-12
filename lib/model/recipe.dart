import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  late String _id;
  late String _recipeName;
  late String _displayName;
  late int _cateId;
  late int _favNum;
  late List<RecipeDetail> _detailList;
  late List<String?> _imageList;

  Recipe({
    required String id,
    required String recipeName,
    required String displayName,
    required int cateId,
    required int favNum,
    required List<RecipeDetail> detailList,
    required List<String> imageList,
  })  : _id = id,
        _recipeName = recipeName,
        _displayName = displayName,
        _cateId = cateId,
        _favNum = favNum,
        _detailList = detailList,
        _imageList = imageList;

  String get recipeName => _recipeName;
  String get username => _displayName;
  int get cateId => _cateId;
  int get favNum => _favNum;
  List<RecipeDetail> get detailList => _detailList;
  List<String?> get imageList => _imageList;

  Recipe.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _recipeName = json["recipeName"];
    _displayName = json["displayName"];
    _cateId = json["cateId"];
    _favNum = json["favNum"];
    _detailList = json["detailList"];
    _imageList = json["imageList"];
  }

  Recipe.fromQuerySnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> recipeSnap,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> detailSnapList,
  ) {
    final data = recipeSnap.data();
    _id = recipeSnap.id;
    _recipeName = data["recipeName"];
    _displayName = data["displayName"];
    _cateId = data["cateId"];
    _favNum = data["favNum"];
    _imageList =
        (data["imageList"] as List<dynamic>).map<String>((e) => e).toList();

    _detailList =
        detailSnapList.map((e) => RecipeDetail.fromSnapshot(e)).toList();
  }

  Recipe.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> recipeSnap,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> detailSnapList,
  ) {
    final data = recipeSnap.data();
    _id = recipeSnap.id;
    if (data != null) {
      _recipeName = data["recipeName"];
      _displayName = data["displayName"];
      _cateId = data["cateId"];
      _favNum = data["favNum"];
      _imageList =
          (data["imageList"] as List<dynamic>).map<String>((e) => e).toList();

      _detailList =
          detailSnapList.map((e) => RecipeDetail.fromSnapshot(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = _id;
    map["recipeName"] = _recipeName;
    map["displayName"] = _displayName;
    map["cateId"] = _cateId;
    map["favNum"] = _favNum;
    map["detailList"] = _detailList;
    map["imageList"] = _imageList;
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