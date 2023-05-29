class Recipe {
  late String _recipeName;
  late String _username;
  late List<RecipeDetail> _detailList;
  late List<String> _imageList;

  Recipe({
    required String recipeName,
    required String username,
    required List<RecipeDetail> detailList,
    required List<String> imageList,
  })  : _recipeName = recipeName,
        _username = username,
        _detailList = detailList,
        _imageList = imageList;

  String get recipeName => _recipeName;
  String get username => _username;
  List<RecipeDetail> get detailList => _detailList;
  List<String> get imageList => _imageList;

  Recipe.fromJson(dynamic json) {
    _recipeName = json["recipeName"];
    _username = json["username"];
    _detailList = json["detailList"];
    _imageList = json["imageList"];
  }

  Map<String, dynamic> toJson(Recipe model) {
    Map<String, dynamic> map = {};
    map["recipeName"] = model.recipeName;
    map["username"] = model.username;
    map["detailList"] = model.detailList;
    map["imageList"] = model.imageList;
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

  Map<String, dynamic> toJson(RecipeDetail model) {
    Map<String, dynamic> map = {};
    map["index"] = model.index;
    map["description"] = model.description;
    return map;
  }
}
