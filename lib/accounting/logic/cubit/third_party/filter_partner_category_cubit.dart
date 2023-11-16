import 'package:bloc/bloc.dart';

enum PartnerCategory { customer, supplier }

class FilterPartnerCategoryCubit extends Cubit<PartnerCategory> {
  FilterPartnerCategoryCubit() : super(PartnerCategory.customer);

  void onSelectionChanged(PartnerCategory selected){
    emit(selected);
  }
}
