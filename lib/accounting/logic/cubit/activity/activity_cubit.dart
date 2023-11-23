import 'package:bloc/bloc.dart';
import 'package:utils/utils.dart';
import 'package:activity_api/activity_api.dart';

class FilterProductTypeCubit extends Cubit<Set<ProductType>> {
  FilterProductTypeCubit() : super({ProductType.bien, ProductType.service, ProductType.mixte});

  void onSelectionChanged(Set<ProductType> selected){
    emit(selected);
  }
}


class ActivityViewModeCubit extends Cubit<ViewMode> {
  ActivityViewModeCubit() : super(ViewMode.list);

  void changeView(ViewMode mode) {
    emit(mode);
  }
}

class ProductBottomNavigationCubit extends Cubit<int> {

  ProductBottomNavigationCubit() : super(0);

  void navigate(int index) {
    emit(index);
  }

}

class SwitchPerishableCubit extends Cubit<bool> {
  SwitchPerishableCubit(): super(false);

  void change(bool state) {
    emit(state);
  }
}

class SwitchInPromoCubit extends Cubit<bool> {
  SwitchInPromoCubit(): super(false);

  void change(bool state) {
    emit(state);
  }
}