import 'package:bloc/bloc.dart';

class LoginPasswordHideCubit extends Cubit<bool> {
  LoginPasswordHideCubit() : super(true);

  void change() {
    emit(!state);
  }
}
