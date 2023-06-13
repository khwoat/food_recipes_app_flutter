import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/favorite_provider.dart';
import '../../model/recipe.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit({required bool isFav})
      : super(FavoriteButtonInitial(isFav: isFav));

  Future<void> changeFav(Recipe recipe, bool isFav) async {
    emit(const FavoriteButtonLoading());
    final newIsFav = !isFav;
    await FavoriteProvider.changeFav(recipe, newIsFav);
    emit(FavoriteButtonAction(isFav: newIsFav));
  }
}
