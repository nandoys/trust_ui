import 'package:bloc/bloc.dart';

class SubmitCreateUserAdminFormLoadingCubit extends Cubit<bool> {
  SubmitCreateUserAdminFormLoadingCubit() : super(false);

  void change(bool value) {
    emit(value);
  }
}
