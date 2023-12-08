import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';

class CheckAccountApiStatusCubit extends Cubit<ApiStatus> {
  CheckAccountApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

