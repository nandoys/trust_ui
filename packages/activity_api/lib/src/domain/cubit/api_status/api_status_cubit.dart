import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';

class ProductCategoryApiStatusCubit extends Cubit<ApiStatus> {
  ProductCategoryApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}

class ProductCategoryConfigApiStatusCubit extends Cubit<ApiStatus> {
  ProductCategoryConfigApiStatusCubit() : super(ApiStatus.requesting);

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}