class UserData {
  late String _displayName;
  late String _email;
  late List<String> _favIds;
  late List<String> _recipeIds;

  String get displayName => _displayName;
  String get email => _email;
  List<String> get favIds => _favIds;
  List<String> get recipeIds => _recipeIds;

  UserData({
    required String displayName,
    required String email,
    required List<String> favIds,
    required List<String> recipeIds,
  })  : _displayName = displayName,
        _email = email,
        _favIds = favIds,
        _recipeIds = recipeIds;

  UserData.defaultValue() {
    _displayName = "";
    _email = "";
    _favIds = [];
    _recipeIds = [];
  }

  UserData.fromJson(dynamic json) {
    _displayName = json["displayName"];
    _email = json["email"];
    _favIds = (json["favIds"] as List).map<String>((e) => e).toList();
    _recipeIds = (json["recipeIds"] as List).map<String>((e) => e).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map["displayName"] = _displayName;
    map["email"] = _email;
    map["favIds"] = _favIds;
    map["recipeIds"] = _recipeIds;
    return map;
  }
}
