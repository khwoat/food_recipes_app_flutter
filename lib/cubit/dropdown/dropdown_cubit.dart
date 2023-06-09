import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dropdown_state.dart';

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(const DropdownInitial());

  void init(List<String>? valueList) {
    emit(DropdownInitial(
      selectedValue: valueList?.first,
      valueList: valueList,
    ));
  }

  void selectNewValue(String value) {
    emit(DropdownAction(
        selectedValue: value, valueList: state.valueList));
  }
}
