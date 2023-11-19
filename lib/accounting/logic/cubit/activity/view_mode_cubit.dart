import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';

class ActivityViewModeCubit extends Cubit<ViewMode> {
  ActivityViewModeCubit() : super(ViewMode.list);

  void changeView(ViewMode mode) {
    emit(mode);
  }
}