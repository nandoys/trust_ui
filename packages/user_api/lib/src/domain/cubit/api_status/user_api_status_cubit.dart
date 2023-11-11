import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';


abstract class UserApiStatusCubit extends Cubit<ApiStatus> {
  UserApiStatusCubit(status) : super(status);

  void changeStatus(ApiStatus status) {}
}

class CreateAdminUserApiStatusCubit extends UserApiStatusCubit {
  CreateAdminUserApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class LoginApiStatusCubit extends UserApiStatusCubit {
  LoginApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}
