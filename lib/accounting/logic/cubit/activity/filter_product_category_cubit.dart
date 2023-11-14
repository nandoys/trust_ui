import 'package:bloc/bloc.dart';

enum ProductCategory { bien, service, mixte }

class FilterProductCategoryCubit extends Cubit<Set<ProductCategory>> {
  FilterProductCategoryCubit() : super({ProductCategory.bien, ProductCategory.service, ProductCategory.mixte});

  void onSelectionChanged(Set<ProductCategory> selected){
    emit(selected);
  }
}
