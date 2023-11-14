import 'package:bloc/bloc.dart';

class SwitchAccountingViewCubit extends Cubit<int> {
  SwitchAccountingViewCubit() : super(0);

  void switchView(int index) {
    emit(index);
  }
}
