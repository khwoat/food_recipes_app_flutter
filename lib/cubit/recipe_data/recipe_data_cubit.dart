import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/repository/recipe_repository.dart';

import '../../model/recipe_model.dart';

part 'recipe_data_state.dart';

class RecipeDataCubit extends Cubit<RecipeDataState> {
  RecipeDataCubit({required this.recipeRepository, required String id})
      : super(RecipeDataInitial()) {
    getRecipeData(id);
  }

  final RecipeRepository recipeRepository;

  Future<void> getRecipeData(String id) async {
    emit(RecipeDataLoading());
    final recipe = await recipeRepository.getRecipe(id);
    emit(RecipeDataSuccess(recipe: recipe));
  }

  Future<void> changeFav(Recipe recipe, bool isFav) async {
    // emit(RecipeDataLoading());
    final newIsFav = !isFav;
    await recipeRepository.changeFav(recipe, newIsFav);
    emit(RecipeDataAction(
      recipe: Recipe.fromJson({
        ...recipe.toJson(),
        "isFav": newIsFav,
      }),
    ));
  }
}
