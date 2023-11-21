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