import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/constants/string.dart';

import '../model/recipe.dart';

class RecipeListProvider {
  RecipeListProvider._();

  static final db = FirebaseFirestore.instance;

  static Future<List<Recipe>> getRecipeList() async {
    final snap = await db.collection(FirestoreString.RECIPES_COL).get();
    final List<Recipe> recipeList = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> e in snap.docs) {
      final detailSnap =
          await e.reference.collection(FirestoreString.DETAIL_RECIPE_COL).get();
      recipeList.add(Recipe.fromSnapshot(e, detailSnap.docs));
    }
    return recipeList;
  }
}
