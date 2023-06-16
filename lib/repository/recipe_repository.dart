import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/constants/string.dart';

import '../firebase/auth.dart';
import '../model/recipe_model.dart';
import '../model/user_recipe_model.dart';

class RecipeRepository {
  final _db = FirebaseFirestore.instance;

  /// Get recipe list to show in dashboard page
  Future<List<Recipe>> getRecipeList() async {
    final uid = AppAuth.userData.id;
    final userSnap = await _db.collection(DbString.USERS_COL).doc(uid).get();
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

  Future<Recipe> getRecipe(String id) async {
    final uid = AppAuth.userData.id;
    final userSnap = await _db.collection(DbString.USERS_COL).doc(uid).get();
    final userRecipe = UserRecipe.fromSnapshot(userSnap);

    final snap = await _db.collection(DbString.RECIPES_COL).doc(id).get();
    final detailSnap =
        await snap.reference.collection(DbString.DETAIL_RECIPE_COL).get();
    return Recipe.fromSnapshot(
      recipeSnap: snap,
      detailSnapList: detailSnap.docs,
      isFav: userRecipe.favIds.contains(id),
    );
  }

  Future<void> changeFav(Recipe recipe, bool isFav) async {
    final uid = AppAuth.userData.id;
    final snap = await _db.collection(DbString.USERS_COL).doc(uid).get();
    final userRecipe = UserRecipe.fromSnapshot(snap);

    final favList = userRecipe.favIds;
    if (isFav && !favList.contains(recipe.id)) {
      favList.add(recipe.id);
    } else if (!isFav) {
      favList.remove(recipe.id);
    }
    await _db.collection(DbString.USERS_COL).doc(uid).update({
      "favIds": favList,
    });
  }
}
