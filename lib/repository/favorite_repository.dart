import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes_flutter/model/user_recipe_model.dart';

import '../constants/string.dart';
import '../firebase/auth.dart';
import '../model/recipe_model.dart';

class FavoriteRepository {
  final _db = FirebaseFirestore.instance;

  // Get User Favorite recipes
  Future<List<Recipe>> getFavoriteList() async {
    final List<Recipe> favList = [];
    final uid = AppAuth.userData.id;
    final snap = await _db.collection(DbString.USERS_COL).doc(uid).get();
    final userRecipe = UserRecipe.fromSnapshot(snap);

    for (String id in userRecipe.favIds) {
      final snap = await _db.collection(DbString.RECIPES_COL).doc(id).get();
      final detailList =
          await snap.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      favList.add(Recipe.fromSnapshot(
        recipeSnap: snap,
        detailSnapList: detailList.docs,
        isFav: userRecipe.favIds.contains(id),
      ));
    }

    return favList;
  }

  // Future<void> changeFav(Recipe recipe, bool isFav) async {
  //   final uid = AppAuth.userData.id;
  //   final snap = await _db.collection(DbString.USERS_COL).doc(uid).get();
  //   final userRecipe = UserRecipe.fromSnapshot(snap);

  //   final favList = userRecipe.favIds;
  //   if (isFav && !favList.contains(recipe.id)) {
  //     favList.add(recipe.id);
  //   } else if (!isFav) {
  //     favList.remove(recipe.id);
  //   }
  //   await _db.collection(DbString.USERS_COL).doc(uid).update({
  //     "favIds": favList,
  //   });
  // }
}
