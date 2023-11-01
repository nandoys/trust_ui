import 'package:bloc/bloc.dart';
import 'package:trust_app/utils.dart';

class OrganisationApiStatusCubit extends Cubit<ApiStatus> {
  OrganisationApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}
