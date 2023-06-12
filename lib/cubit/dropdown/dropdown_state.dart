part of 'dropdown_cubit.dart';

@immutable
abstract class DropdownState extends Equatable {
  final int? _selectedValue;
  final List<String>? _valueList;
  const DropdownState({
    int? selectedValue,
    List<String>? valueList,
  })  : _selectedValue = selectedValue,
        _valueList = valueList;

  int get selectedValue => _selectedValue ?? 0;
  List<String> get valueList => _valueList ?? [];

  @override
  List<Object?> get props => [_selectedValue, _valueList];
}

class DropdownInitial extends DropdownState {}

class DropdownLoading extends DropdownState {}

class DropdownAction extends DropdownState {
  const DropdownAction({
    required super.selectedValue,
    required super.valueList,
  });
}
