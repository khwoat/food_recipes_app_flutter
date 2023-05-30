import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/recipe_list.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit() : super(const FavoriteListInitial());

  void init(List<Recipe> favList) {
    emit(FavoriteListInitial(favList: favList));
  }
}
