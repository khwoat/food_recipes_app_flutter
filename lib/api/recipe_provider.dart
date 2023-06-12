import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/constants/string.dart';

import '../firebase/auth.dart';
import '../model/recipe.dart';

class RecipeProvider {
  RecipeProvider._();

  static final db = FirebaseFirestore.instance;
  static final userData = AppAuth.userData;

  // Get recipe list to show in dashboard page
  static Future<List<Recipe>> getRecipeList() async {
    final snap = await db.collection(DbString.RECIPES_COL).get();
    final List<Recipe> recipeList = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> e in snap.docs) {
      final detailSnap =
          await e.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      recipeList.add(Recipe.fromQuerySnapshot(
        recipeSnap: e,
        detailSnapList: detailSnap.docs,
        isFav: userData.favIds.contains(e.id),
      ));
    }
    return recipeList;
  }

  // Get dropdown (category, sorting) item from database
  static Future<List<String>> getDropdownItemList(String doc) async {
    final snap = await db.collection(DbString.DROPDOWN_COL).doc(doc).get();
    return (snap.data()?["list"] as List).map<String>((e) => e).toList();
  }
}
