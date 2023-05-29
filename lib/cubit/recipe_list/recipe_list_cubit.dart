import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/model/recipe_list.dart';

part 'recipe_list_state.dart';

class RecipeListCubit extends Cubit<RecipeListState> {
  RecipeListCubit() : super(const RecipeListInitial());

  void init(List<Recipe> recipeList) {
    emit(RecipeListInitial(recipeList: recipeList));
  }
}
