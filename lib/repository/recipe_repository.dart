import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/constants/string.dart';

import '../firebase/auth.dart';
import '../model/recipe.dart';
import '../model/user_recipe.dart';

class RecipeRepository {
  final _db = FirebaseFirestore.instance;
  final _userData = AppAuth.userData;

  // Get recipe list to show in dashboard page
  Future<List<Recipe>> getRecipeList() async {
    final userSnap =
        await _db.collection(DbString.USERS_COL).doc(_userData.id).get();
    final userRecipe = UserRecipe.fromSnapshot(userSnap);

    final snap = await _db.collection(DbString.RECIPES_COL).get();
    final List<Recipe> recipeList = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> e in snap.docs) {
      final detailSnap =
          await e.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      recipeList.add(Recipe.fromQuerySnapshot(
        recipeSnap: e,
        detailSnapList: detailSnap.docs,
        isFav: userRecipe.favIds.contains(e.id),
      ));
    }
    return recipeList;
  }
}
