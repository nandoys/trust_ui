import 'package:bloc/bloc.dart';

class PasswordHideCubit extends Cubit<bool> {
  PasswordHideCubit() : super(true);

  void change() {
    emit(!state);
  }
}
