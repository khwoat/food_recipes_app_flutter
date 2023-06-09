import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'cubit/recipe_list/recipe_list_cubit.dart';

class AppBlocProvider {
  final _recipesCubit = BlocProvider<RecipeListCubit>(
    create: (context) => RecipeListCubit(),
  );
  final _favCubit = BlocProvider<FavoriteListCubit>(
    create: (context) => FavoriteListCubit(),
  );

  List<BlocProvider> getAllProvider() {
    return [_recipesCubit, _favCubit];
  }
}
