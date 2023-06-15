import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/favorite_repository.dart';
import '../../model/recipe.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository,
        super(const FavoriteButtonInitial());

  final FavoriteRepository _favoriteRepository;

  void setFav(bool isFav) {
    emit(FavoriteButtonAction(isFav: isFav));
  }

  Future<void> changeFav(Recipe recipe, bool isFav) async {
    emit(const FavoriteButtonLoading());
    final newIsFav = !isFav;
    await _favoriteRepository.changeFav(recipe, newIsFav);
    emit(FavoriteButtonAction(isFav: newIsFav));
  }
}
