part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState extends Equatable {
  const FavoriteButtonState({required this.isFav});

  final bool isFav;

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitial extends FavoriteButtonState {
  const FavoriteButtonInitial({required super.isFav});
}

class FavoriteButtonLoading extends FavoriteButtonState {
  const FavoriteButtonLoading({super.isFav = false});
}

class FavoriteButtonAction extends FavoriteButtonState {
  const FavoriteButtonAction({required super.isFav});
}
