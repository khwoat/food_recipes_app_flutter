import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/string.dart';
import '../firebase/auth.dart';
import '../model/recipe.dart';

class FavoriteProvider {
  FavoriteProvider._();

  static final db = FirebaseFirestore.instance;
  static final userData = AppAuth.userData;

  // Get User Favorite recipes
  static Future<List<Recipe>> getFavoriteList() async {
    final List<Recipe> favList = [];
    for (String id in userData.favIds) {
      final snap = await db.collection(DbString.RECIPES_COL).doc(id).get();
      final detailSnapList =
          await snap.reference.collection(DbString.DETAIL_RECIPE_COL).get();
      favList.add(Recipe.fromSnapshot(
        recipeSnap: snap,
        detailSnapList: detailSnapList.docs,
        isFav: userData.favIds.contains(snap.id),
      ));
    }

    return favList;
  }

  static Future<List<Recipe>> changeFav(Recipe recipe, bool isFav) async {
    final favList = userData.favIds;
    if (isFav) {
      favList.add(recipe.id);
    } else {
      favList.remove(recipe.id);
    }
    await db.collection(DbString.USERS_COL).doc(userData.id).update({
      "favIds": favList,
    });

    return await getFavoriteList();
  }
}
