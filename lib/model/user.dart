class UserData {
  late String _displayName;
  late String _email;
  late List<int> _favIds;
  late List<int> _recipeIds;

  String get displayName => _displayName;
  String get email => _email;
  List<int> get favIds => _favIds;
  List<int> get recipeIds => _recipeIds;

  UserData({
    required String displayName,
    required String email,
    required List<int> favIds,
    required List<int> recipeIds,
  })  : _displayName = displayName,
        _email = email,
        _favIds = favIds,
        _recipeIds = recipeIds;

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
