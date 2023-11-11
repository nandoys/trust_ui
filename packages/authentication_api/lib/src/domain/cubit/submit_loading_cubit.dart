import 'package:bloc/bloc.dart';

class SubmitLoginFormLoadingCubit extends Cubit<bool> {
  SubmitLoginFormLoadingCubit() : super(false);

  void change(bool value) {
    emit(value);
  }
}
