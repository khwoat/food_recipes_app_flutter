part of 'sort_dropdown_cubit.dart';

@immutable
abstract class SortDropdownState extends Equatable {
  final String? _selectedValue;
  final List<String>? _valueList;
  const SortDropdownState({
    String? selectedValue,
    List<String>? valueList,
  })  : _selectedValue = selectedValue,
        _valueList = valueList;

  String get selectedValue => _selectedValue ?? "";
  List<String> get valueList => _valueList ?? [];

  @override
  List<Object?> get props => [_selectedValue, _valueList];
}

class SortDropdownInitial extends SortDropdownState {
  const SortDropdownInitial({super.selectedValue, super.valueList});
}

class SortDropdownAction extends SortDropdownState {
  const SortDropdownAction({
    required super.selectedValue,
    required super.valueList,
  });
}
