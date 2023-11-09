import 'package:bloc/bloc.dart';
import 'package:trust_app/utils.dart';

class OrganisationApiStatusCubit extends Cubit<ApiStatus> {
  OrganisationApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class TypeOrganisationApiStatusCubit extends Cubit<ApiStatus> {
  TypeOrganisationApiStatusCubit() : super(ApiStatus.requesting);

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

class CreateAdminUserApiStatusCubit extends Cubit<ApiStatus> {
  CreateAdminUserApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}