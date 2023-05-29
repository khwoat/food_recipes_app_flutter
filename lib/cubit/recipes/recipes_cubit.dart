import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/model/recipe.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit() : super(const RecipesInitial());

  void init(List<Recipe> recipeList) {
    emit(RecipesInitial(recipeList: recipeList));
  }
}
