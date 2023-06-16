import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/repository/favorite_repository.dart';

import '../../model/recipe_model.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository,
        super(const FavoriteListInitial()) {
    getFavoriteList();
  }

  final FavoriteRepository _favoriteRepository;

  Future<List<Recipe>> getFavoriteList() async {
    emit(FavoriteListLoading());
    final favList = await _favoriteRepository.getFavoriteList();
    emit(FavoriteListSuccess(favList: favList));
    return favList;
  }
}
