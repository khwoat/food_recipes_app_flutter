import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecipe {
  late String _id;
  late List<String> _favIds;
  late List<String> _recipeIds;

  String get id => _id;
  List<String> get favIds => _favIds;
  List<String> get recipeIds => _recipeIds;

  UserRecipe({
    required String id,
    required List<String> favIds,
    required List<String> recipeIds,
  })  : _id = id,
        _favIds = favIds,
        _recipeIds = recipeIds;

  UserRecipe.defaultValue() {
    _id = "";
    _favIds = [];
    _recipeIds = [];
  }

  UserRecipe.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _favIds = (json["favIds"] as List).map<String>((e) => e).toList();
    _recipeIds = (json["recipeIds"] as List).map<String>((e) => e).toList();
  }

  UserRecipe.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    _id = snap.id;
    if (data != null) {
      _favIds = (data["favIds"] as List).map<String>((e) => e).toList();
      _recipeIds = (data["recipeIds"] as List).map<String>((e) => e).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map["favIds"] = _favIds;
    map["recipeIds"] = _recipeIds;
    return map;
  }
}
