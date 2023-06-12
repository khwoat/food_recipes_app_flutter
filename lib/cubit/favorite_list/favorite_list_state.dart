part of 'favorite_list_cubit.dart';

abstract class FavoriteListState extends Equatable {
  final List<Recipe>? _favList;
  const FavoriteListState({
    List<Recipe>? favList,
  }) : _favList = favList;

  List<Recipe> get favList => _favList ?? [];

  @override
  List<Object?> get props => [_favList];
}

class FavoriteListInitial extends FavoriteListState {
  const FavoriteListInitial({super.favList});
}

class FavoriteListLoading extends FavoriteListState {}

class FavoriteListAction extends FavoriteListState {
  const FavoriteListAction({super.favList});
}
