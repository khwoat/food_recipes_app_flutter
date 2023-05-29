import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/cubit/sort_dropdown/sort_dropdown_cubit.dart';

import 'cubit/cate_dropdown/cate_dropdown_cubit.dart';
import 'cubit/recipe_list/recipe_list_cubit.dart';

class AppBlocProvider {
  final _cateDropdownCubit = BlocProvider<CategoryDropdownCubit>(
    create: (context) => CategoryDropdownCubit(),
  );

  final _sortDropdownCubit = BlocProvider<SortDropdownCubit>(
    create: (context) => SortDropdownCubit(),
  );

  final _recipesCubit = BlocProvider<RecipeListCubit>(
    create: (context) => RecipeListCubit(),
  );

  List<BlocProvider> getAllProvider() {
    return [_cateDropdownCubit, _sortDropdownCubit, _recipesCubit];
  }
}
