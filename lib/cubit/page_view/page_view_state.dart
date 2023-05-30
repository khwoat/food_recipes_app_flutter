part of 'page_view_cubit.dart';

abstract class PageViewState extends Equatable {
  final List<Widget>? _pageList;
  final List<bool>? _isSelectedList;
  const PageViewState({List<Widget>? pageList, List<bool>? isSelectedList})
      : _pageList = pageList,
        _isSelectedList = isSelectedList;

  List<Widget> get pageList => _pageList ?? [];
  List<bool> get isSelectedList => _isSelectedList ?? [];

  @override
  List<Object?> get props => [_pageList, _isSelectedList];
}

class PageViewInitial extends PageViewState {
  const PageViewInitial({super.pageList, super.isSelectedList});
}

class PageViewAction extends PageViewState {
  const PageViewAction({super.pageList, super.isSelectedList});
}
