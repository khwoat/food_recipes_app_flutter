import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipes_flutter/repository/recipe_repository.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:meta/meta.dart';

part 'dropdown_state.dart';

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownInitial());

  void init(List<String> valueList) {
    emit(DropdownAction(
      selectedValue: 0,
      valueList: valueList,
    ));
  }

  Future<void> getValueList(String doc) async {
    emit(DropdownLoading());

    List<String> valueList = [];
    if (doc == DbString.CATEGORIES_DOC) {
      valueList = await RecipeRepository.getDropdownItemList(
        DbString.CATEGORIES_DOC,
      );
    } else if (doc == DbString.SORTING_DOC) {
      valueList = await RecipeRepository.getDropdownItemList(
        DbString.SORTING_DOC,
      );
    }

    emit(DropdownAction(selectedValue: 0, valueList: valueList));
  }

  void selectNewValue(int value) {
    emit(DropdownAction(selectedValue: value, valueList: state.valueList));
  }
}
