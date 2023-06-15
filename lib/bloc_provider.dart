import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'package:food_recipes_flutter/repository/dropdown_repository.dart';
import 'package:food_recipes_flutter/repository/favorite_repository.dart';
import 'package:food_recipes_flutter/repository/recipe_repository.dart';
import 'constants/string.dart';
import 'cubit/dropdown/dropdown_cubit.dart';
import 'cubit/recipe_list/recipe_list_cubit.dart';

class AppBlocProvider {
  final _recipesCubit = BlocProvider<RecipeListCubit>(
    create: (context) => RecipeListCubit(recipeRepository: RecipeRepository()),
  );
  final _favCubit = BlocProvider<FavoriteListCubit>(
    create: (context) =>
        FavoriteListCubit(favoriteRepository: FavoriteRepository()),
  );

  final _cateDropdownCubit = BlocProvider(
    create: (context) => DropdownCubit<CateDropdownType>(
      dropdownRepository: DropdownRepository(),
      doc: DbString.CATEGORIES_DOC,
    ),
  );
  final _sortDropdownCubit = BlocProvider(
    create: (context) => DropdownCubit<SortDropdownType>(
      dropdownRepository: DropdownRepository(),
      doc: DbString.SORTING_DOC,
    ),
  );

  List<BlocProvider> getAllProvider() {
    return [_recipesCubit, _favCubit, _cateDropdownCubit, _sortDropdownCubit];
  }
}
