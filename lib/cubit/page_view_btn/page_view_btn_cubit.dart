import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_view_btn_state.dart';

class PageViewBtnCubit extends Cubit<PageViewBtnState> {
  PageViewBtnCubit() : super(const PageViewBtnInitial(pageIndex: 0));

  void changePageIndex(int index) {
    emit(PageViewBtnAction(pageIndex: index));
  }
}
