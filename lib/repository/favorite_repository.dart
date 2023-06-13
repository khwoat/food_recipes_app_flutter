import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/model/user_recipe.dart';

import '../constants/string.dart';
import '../firebase/auth.dart';
import '../model/recipe.dart';

class FavoriteRepository {
  FavoriteRepository._();

  static final _db = FirebaseFirestore.instance;
  static final _userData = AppAuth.userData;

  // Get User Favorite recipes
  static Future<List<Recipe>> getFavoriteList() async {
    final List<Recipe> favList = [];
    final snap =
        await _db.collection(DbString.USERS_COL).doc(_userData.id).get();
    final userRecipe = UserRecipe.fromSnapshot(snap);

    for (String id in userRecipe.favIds) {
      final snap = await _db.collection(DbString.RECIPES_COL).doc(id).get();
      final detailSnapList =
          await snap.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      favList.add(Recipe.fromSnapshot(
        recipeSnap: snap,
        detailSnapList: detailSnapList.docs,
        isFav: userRecipe.favIds.contains(snap.id),
      ));
    }

    return favList;
  }

  static Future<void> changeFav(Recipe recipe, bool isFav) async {
    final snap =
        await _db.collection(DbString.USERS_COL).doc(_userData.id).get();
    final userRecipe = UserRecipe.fromSnapshot(snap);

    final favList = userRecipe.favIds;
    if (isFav && !favList.contains(recipe.id)) {
      favList.add(recipe.id);
    } else if (!isFav) {
      favList.remove(recipe.id);
    }
    await _db.collection(DbString.USERS_COL).doc(_userData.id).update({
      "favIds": favList,
    });
  }
}
