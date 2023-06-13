import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/repository/favorite_repository.dart';

import '../../model/recipe.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit() : super(const FavoriteListInitial());

  Future<void> getFavoriteList() async {
    emit(FavoriteListLoading());
    final favList = await FavoriteRepository.getFavoriteList();
    emit(FavoriteListAction(favList: favList));
  }
}
