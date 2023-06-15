part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState extends Equatable {
  const FavoriteButtonState({this.isFav});

  final bool? isFav;

  @override
  List<Object?> get props => [isFav];
}

class FavoriteButtonInitial extends FavoriteButtonState {
  const FavoriteButtonInitial();
}

class FavoriteButtonLoading extends FavoriteButtonState {
  const FavoriteButtonLoading();
}

class FavoriteButtonAction extends FavoriteButtonState {
  const FavoriteButtonAction({required super.isFav});
}
