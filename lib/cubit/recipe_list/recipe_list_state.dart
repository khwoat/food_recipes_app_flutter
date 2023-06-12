part of 'recipe_list_cubit.dart';

abstract class RecipeListState extends Equatable {
  const RecipeListState({
    List<Recipe>? recipeList,
    int? listLength,
  })  : _recipeList = recipeList,
        _listLength = listLength;

  final List<Recipe>? _recipeList;
  final int? _listLength;

  List<Recipe> get recipeList => _recipeList ?? [];
  int get listLength => _listLength ?? 0;

  @override
  List<Object?> get props => [_recipeList, _listLength];
}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {}

class RecipeListAction extends RecipeListState {
  const RecipeListAction({required super.recipeList});
}
