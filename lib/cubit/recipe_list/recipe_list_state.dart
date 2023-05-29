part of 'recipe_list_cubit.dart';

abstract class RecipeListState extends Equatable {
  final List<Recipe>? _recipeList;
  const RecipeListState({
    List<Recipe>? recipeList,
  }) : _recipeList = recipeList;

  List<Recipe> get recipeList => _recipeList ?? [];

  @override
  List<Object?> get props => [_recipeList];
}

class RecipeListInitial extends RecipeListState {
  const RecipeListInitial({super.recipeList});
}

class RecipeListAction extends RecipeListState {
  const RecipeListAction({required super.recipeList});
}
