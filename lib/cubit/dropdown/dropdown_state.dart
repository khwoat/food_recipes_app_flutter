part of 'dropdown_cubit.dart';

@immutable
abstract class DropdownState extends Equatable {
  final String? _selectedValue;
  final List<String>? _valueList;
  const DropdownState({
    String? selectedValue,
    List<String>? valueList,
  })  : _selectedValue = selectedValue,
        _valueList = valueList;

  String get selectedValue => _selectedValue ?? "";
  List<String> get valueList => _valueList ?? [];

  @override
  List<Object?> get props => [_selectedValue, _valueList];
}

class DropdownInitial extends DropdownState {
  const DropdownInitial({super.selectedValue, super.valueList});
}

class DropdownAction extends DropdownState {
  const DropdownAction({
    required super.selectedValue,
    required super.valueList,
  });
}
