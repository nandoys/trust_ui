import 'package:bloc/bloc.dart';

enum ViewMode {grid, list}

class ViewModeCubit extends Cubit<ViewMode> {
  ViewModeCubit() : super(ViewMode.list);

  void changeView(ViewMode mode) {
    emit(mode);
  }
}
