import 'package:bloc/bloc.dart';
import 'package:organisation_api/organisation_api.dart';

class SelectedTypeOrganisationCubit extends Cubit<TypeOrganisation?> {
  SelectedTypeOrganisationCubit() : super(null);

  void change(TypeOrganisation? type) {
    emit(type);
  }
}
