part of 'cate_dropdown_cubit.dart';

@immutable
abstract class CategoryDropdownState extends Equatable {
  final String? _selectedValue;
  final List<String>? _valueList;
  const CategoryDropdownState({
    String? selectedValue,
    List<String>? valueList,
  })  : _selectedValue = selectedValue,
        _valueList = valueList;

  String get selectedValue => _selectedValue ?? "";
  List<String> get valueList => _valueList ?? [];

  @override
  List<Object?> get props => [_selectedValue, _valueList];
}

class CategoryDropdownInitial extends CategoryDropdownState {
  const CategoryDropdownInitial({super.selectedValue, super.valueList});
}

class CategoryDropdownAction extends CategoryDropdownState {
  const CategoryDropdownAction({
    required super.selectedValue,
    required super.valueList,
  });
}
