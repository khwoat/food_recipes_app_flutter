import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/api/recipe_provider.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/model/recipe.dart';

part 'recipe_list_state.dart';

enum SortingBy { mostFav, name }

class RecipeListCubit extends Cubit<RecipeListState> {
  RecipeListCubit() : super(RecipeListInitial());

  List<Recipe> immortalRecipeList = [];

  Future<void> getRecipeList() async {
    emit(const RecipeListLoading());
    immortalRecipeList = await RecipeProvider.getRecipeList();
    emit(RecipeListAction(recipeList: immortalRecipeList));
  }

  // Filter recipes (Category and Sorting)
  void filterRecipes({
    required int cateId,
    required int sortId,
    required List<String> sortingList,
  }) {
    List<Recipe> newList = [];

    // Category
    if (cateId != 0) {
      newList = immortalRecipeList.where((e) => e.cateId == cateId).toList();
    } else {
      newList = immortalRecipeList;
    }

    emit(RecipeListLoading(recipeList: newList));

    // Sorting
    if (sortId != 0) {
      if (sortingList[sortId] == DbString.MF_SORT_VALUE) {
        newList.sort((a, b) => b.favNum - a.favNum);
      } else if (sortingList[sortId] == DbString.NAME_SORT_VALUE) {
        newList.sort((a, b) => a.recipeName.compareTo(b.recipeName));
      }
    }
    emit(RecipeListAction(recipeList: newList));
  }
}
