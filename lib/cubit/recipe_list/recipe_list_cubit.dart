import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/api/recipe_list_provider.dart';
import 'package:food_recipes_flutter/model/recipe.dart';

part 'recipe_list_state.dart';

class RecipeListCubit extends Cubit<RecipeListState> {
  RecipeListCubit() : super(RecipeListInitial());

  Future<void> getRecipeList() async {
    emit(RecipeListLoading());

    final recipeList = await RecipeProvider.getRecipeList();

    emit(RecipeListAction(recipeList: recipeList));
  }
}
