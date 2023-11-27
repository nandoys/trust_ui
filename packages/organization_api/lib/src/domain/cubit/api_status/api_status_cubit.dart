import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';

class OrganizationApiStatusCubit extends Cubit<ApiStatus> {
  OrganizationApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class OrganizationTypeApiStatusCubit extends Cubit<ApiStatus> {
  OrganizationTypeApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class CountryApiStatusCubit extends Cubit<ApiStatus> {
  CountryApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class UserRoleApiStatusCubit extends Cubit<ApiStatus> {
  UserRoleApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class UserFieldApiStatusCubit extends Cubit<ApiStatus> {
  UserFieldApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class EmailFieldApiStatusCubit extends Cubit<ApiStatus> {
  EmailFieldApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}