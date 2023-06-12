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
      recipeList.add(Recipe.fromQuerySnapshot(e, detailSnap.docs));
    }
    return recipeList;
  }

  // Get dropdown (category, sorting) item from database
  static Future<List<String>> getDropdownItemList(String doc) async {
    final snap = await db.collection(DbString.DROPDOWN_COL).doc(doc).get();
    return (snap.data()?["list"] as List).map<String>((e) => e).toList();
  }

  // Get User Favorite recipes
  static Future<List<Recipe>> getFavoriteList() async {
    final List<Recipe> favList = [];
    print(userData.favIds);
    for (String id in userData.favIds) {
      final snap = await db.collection(DbString.RECIPES_COL).doc(id).get();
      final detailSnapList =
          await snap.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      favList.add(Recipe.fromSnapshot(snap, detailSnapList.docs));
    }

    return favList;
  }
}
