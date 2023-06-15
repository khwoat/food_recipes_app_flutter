import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  late String _id;
  late String _displayName;
  late String _email;
  late List<String> _favIds;
  late List<String> _recipeIds;

  String get id => _id;
  String get displayName => _displayName;
  String get email => _email;
  List<String> get favIds => _favIds;
  List<String> get recipeIds => _recipeIds;

  UserData({
    required String id,
    required String displayName,
    required String email,
    required List<String> favIds,
    required List<String> recipeIds,
  })  : _id = id,
        _displayName = displayName,
        _email = email,
        _favIds = favIds,
        _recipeIds = recipeIds;

  UserData.defaultValue() {
    _id = "";
    _displayName = "";
    _email = "";
  }

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? "";
    _displayName = json["displayName"];
    _email = json["email"];
    _favIds = (json["favIds"] as List).map<String>((e) => e).toList();
    _recipeIds = (json["recipeIds"] as List).map<String>((e) => e).toList();
  }

  UserData.fromCredJson(Map<String, dynamic> json) {
    _id = json["id"] ?? "";
    _displayName = json["displayName"];
    _email = json["email"];
  }

  UserData.fromCredAndSnap(
    UserCredential cred,
    DocumentSnapshot<Map<String, dynamic>> snap,
  ) {
    final userData = cred.user;
    if (userData != null) {
      _id = userData.uid;
      _displayName = userData.displayName ?? "";
      _email = userData.email ?? "";
    }
    final data = snap.data();
    if (data != null) {
      _favIds = (data["favIds"] as List).map<String>((e) => e).toList();
      _recipeIds = (data["recipeIds"] as List).map<String>((e) => e).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map["id"] = _id;
    map["displayName"] = _displayName;
    map["email"] = _email;
    map["favIds"] = _favIds;
    map["recipeIds"] = _recipeIds;
    return map;
  }

  Map<String, dynamic> toCredJson() {
    final Map<String, dynamic> map = {};
    map["id"] = _id;
    map["displayName"] = _displayName;
    map["email"] = _email;
    return map;
  }

  Map<String, dynamic> toJsonWithoutId() {
    final Map<String, dynamic> map = {};
    map["displayName"] = _displayName;
    map["email"] = _email;
    map["favIds"] = _favIds;
    map["recipeIds"] = _recipeIds;
    return map;
  }
}
