part of 'recipe_data_cubit.dart';

abstract class RecipeDataState extends Equatable {
  const RecipeDataState({this.recipe});

  final Recipe? recipe;

  @override
  List<Object?> get props => [recipe];
}

class RecipeDataInitial extends RecipeDataState {}

class RecipeDataLoading extends RecipeDataState {}

class RecipeDataSuccess extends RecipeDataState {
  const RecipeDataSuccess({required super.recipe});
}
