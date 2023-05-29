import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cate_dropdown_state.dart';

class CategoryDropdownCubit extends Cubit<CategoryDropdownState> {
  CategoryDropdownCubit() : super(const CategoryDropdownInitial());

  void init(List<String>? valueList) {
    emit(CategoryDropdownInitial(
      selectedValue: valueList?.first,
      valueList: valueList,
    ));
  }

  void selectNewValue(String value) {
    emit(CategoryDropdownAction(
        selectedValue: value, valueList: state.valueList));
  }
}
