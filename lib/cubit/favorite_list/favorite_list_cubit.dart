import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/api/recipe_list_provider.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';

import '../../model/recipe.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit() : super(const FavoriteListInitial());

  Future<void> getFavoriteList() async {
    emit(FavoriteListLoading());
    final favList = await RecipeProvider.getFavoriteList();
    emit(FavoriteListAction(favList: favList));
  }
}
