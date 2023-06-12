class UserData {
  late String _displayName;
  late String _email;
  late List<dynamic> _favIds;
  late List<dynamic> _recipeIds;

  String get displayName => _displayName;
  String get email => _email;
  List<dynamic> get favIds => _favIds;
  List<dynamic> get recipeIds => _recipeIds;

  UserData({
    required String displayName,
    required String email,
    required List<int> favIds,
    required List<int> recipeIds,
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
    _favIds = json["favIds"];
    _recipeIds = json["recipeIds"];
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
