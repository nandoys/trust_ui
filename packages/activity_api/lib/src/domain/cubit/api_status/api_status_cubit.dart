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

class ProductApiStatusCubit extends Cubit<ApiStatus> {
  ProductApiStatusCubit() : super(ApiStatus.requesting);

  Actions? action = null;
  String? view = null;

  void changeStatus(ApiStatus status) {
    emit(status);
  }

}
