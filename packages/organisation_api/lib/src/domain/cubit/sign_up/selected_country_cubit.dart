import 'package:bloc/bloc.dart';
import 'package:organisation_api/organisation_api.dart';

class SelectedCountryCubit extends Cubit<Country?> {
  SelectedCountryCubit() : super(null);

  void change(Country? country) {
    emit(country);
  }
}
