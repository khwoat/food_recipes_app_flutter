import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'page_view_state.dart';

class PageViewCubit extends Cubit<PageViewState> {
  PageViewCubit() : super(const PageViewInitial());

  void init(List<Widget> pageList) {
    emit(PageViewInitial(
      pageList: pageList,
      isSelectedList: pageList.map((e) => e == pageList.first).toList(),
    ));
  }

  void changePage(Widget page) {
    final newSelectedList = state.pageList.map((e) => e == page).toList();
    emit(PageViewAction(
      pageList: state.pageList,
      isSelectedList: newSelectedList,
    ));
  }
}
