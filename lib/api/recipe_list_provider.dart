import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/constants/string.dart';

import '../model/recipe.dart';

class RecipeProvider {
  RecipeProvider._();

  static final db = FirebaseFirestore.instance;

  // Get recipe list to show in dashboard page
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

  // Get dropdown (category, sorting) item from database
  static Future<List<String>> getDropdownItemList(String doc) async {
    final snap =
        await db.collection(FirestoreString.DROPDOWN_COL).doc(doc).get();
    return (snap.data()?["list"] as List).map<String>((e) => e).toList();
  }
}
