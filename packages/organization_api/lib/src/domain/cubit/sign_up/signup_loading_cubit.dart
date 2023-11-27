import 'package:bloc/bloc.dart';

class SignupLoadingCubit extends Cubit<bool> {
  SignupLoadingCubit() : super(false);

  void change(bool value) {
    emit(value);
  }
}
