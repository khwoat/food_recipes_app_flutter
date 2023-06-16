import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  late String _id;
  late String _displayName;
  late String _email;

  String get id => _id;
  String get displayName => _displayName;
  String get email => _email;

  UserData({
    required String id,
    required String displayName,
    required String email,
  })  : _id = id,
        _displayName = displayName,
        _email = email;

  UserData.defaultValue() {
    _id = "";
    _displayName = "";
    _email = "";
  }

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? "";
    _displayName = json["displayName"];
    _email = json["email"];
  }

  UserData.fromCred(UserCredential cred) {
    final userData = cred.user;
    if (userData != null) {
      _id = userData.uid;
      _displayName = userData.displayName ?? "";
      _email = userData.email ?? "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map["id"] = _id;
    map["displayName"] = _displayName;
    map["email"] = _email;
    return map;
  }
}
