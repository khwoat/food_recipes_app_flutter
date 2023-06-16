part of 'recipe_list_cubit.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState({
    List<Recipe>? recipeList,
  }) : _recipeList = recipeList;

  final List<Recipe>? _recipeList;

  List<Recipe> get recipeList => _recipeList ?? [];

  @override
  List<Object?> get props => [_recipeList];
}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {
  const RecipeListLoading();
}

class RecipeListAction extends RecipeListState {
  const RecipeListAction({required super.recipeList});
}

class RecipeListSuccess extends RecipeListState {
  const RecipeListSuccess({required super.recipeList});
}
