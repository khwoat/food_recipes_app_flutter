class Recipe {
  late String _recipeName;
  late String _displayName;
  late List<RecipeDetail> _detailList;
  late List<String?> _imageList;

  Recipe({
    required String recipeName,
    required String displayName,
    required List<RecipeDetail> detailList,
    required List<String> imageList,
  })  : _recipeName = recipeName,
        _displayName = displayName,
        _detailList = detailList,
        _imageList = imageList;

  String get recipeName => _recipeName;
  String get username => _displayName;
  List<RecipeDetail> get detailList => _detailList;
  List<String?> get imageList => _imageList;

  Recipe.fromJson(dynamic json) {
    _recipeName = json["recipeName"];
    _displayName = json["displayName"];
    _detailList = json["detailList"];
    _imageList = json["imageList"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["recipeName"] = _recipeName;
    map["displayName"] = _displayName;
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["index"] = _index;
    map["description"] = _description;
    return map;
  }
}
