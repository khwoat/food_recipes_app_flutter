part of 'recipes_cubit.dart';

abstract class RecipesState extends Equatable {
  final List<Recipe>? _recipeList;
  const RecipesState({
    List<Recipe>? recipeList,
  }) : _recipeList = recipeList;

  List<Recipe> get recipeList => _recipeList ?? [];

  @override
  List<Object?> get props => [_recipeList];
}

class RecipesInitial extends RecipesState {
  const RecipesInitial({super.recipeList});
}

class RecipesAction extends RecipesState {
  const RecipesAction({required super.recipeList});
}
