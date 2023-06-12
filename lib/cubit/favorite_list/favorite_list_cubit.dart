import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/api/favorite_provider.dart';

import '../../model/recipe.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit() : super(const FavoriteListInitial());

  Future<void> getFavoriteList() async {
    emit(FavoriteListLoading());
    final favList = await FavoriteProvider.getFavoriteList();
    emit(FavoriteListAction(favList: favList));
  }

  Future<void> changeFav(Recipe recipe) async {
    emit(FavoriteListLoading());
    final newIsFav = !recipe.isFav;
    final favList = await FavoriteProvider.changeFav(recipe, newIsFav);
    emit(FavoriteListAction(favList: favList));
  }
}
