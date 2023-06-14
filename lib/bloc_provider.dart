import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'constants/string.dart';
import 'cubit/dropdown/dropdown_cubit.dart';
import 'cubit/recipe_list/recipe_list_cubit.dart';

class AppBlocProvider {
  final _recipesCubit = BlocProvider<RecipeListCubit>(
    create: (context) => RecipeListCubit(),
  );
  final _favCubit = BlocProvider<FavoriteListCubit>(
    create: (context) => FavoriteListCubit(),
  );

  final _cateDropdownCubit = BlocProvider(
    create: (context) =>
        DropdownCubit<CateDropdownType>(doc: DbString.CATEGORIES_DOC),
  );
  final _sortDropdownCubit = BlocProvider(
    create: (context) =>
        DropdownCubit<SortDropdownType>(doc: DbString.SORTING_DOC),
  );

  List<BlocProvider> getAllProvider() {
    return [_recipesCubit, _favCubit, _cateDropdownCubit, _sortDropdownCubit];
  }
}
