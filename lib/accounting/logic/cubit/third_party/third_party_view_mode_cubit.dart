import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';

class ThirdPartyViewModeCubit extends Cubit<ViewMode> {
  ThirdPartyViewModeCubit() : super(ViewMode.list);

  void changeView(ViewMode mode) {
    emit(mode);
  }
}
