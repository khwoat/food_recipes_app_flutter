import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sort_dropdown_state.dart';

class SortDropdownCubit extends Cubit<SortDropdownState> {
  SortDropdownCubit() : super(const SortDropdownInitial());

  void init(List<String>? valueList) {
    emit(SortDropdownInitial(
      selectedValue: valueList?.first,
      valueList: valueList,
    ));
  }

  void selectNewValue(String value) {
    emit(SortDropdownAction(selectedValue: value, valueList: state.valueList));
  }
}
