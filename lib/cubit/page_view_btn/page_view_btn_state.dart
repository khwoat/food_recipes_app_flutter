part of 'page_view_btn_cubit.dart';

abstract class PageViewBtnState extends Equatable {
  const PageViewBtnState({required this.pageIndex});

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}

class PageViewBtnInitial extends PageViewBtnState {
  const PageViewBtnInitial({required super.pageIndex});
}

class PageViewBtnAction extends PageViewBtnState {
  const PageViewBtnAction({required super.pageIndex});
}
