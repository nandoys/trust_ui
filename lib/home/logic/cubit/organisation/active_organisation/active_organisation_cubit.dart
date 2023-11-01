import 'package:bloc/bloc.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class ActiveOrganisationCubit extends Cubit<Organisation?> {
  ActiveOrganisationCubit({required this.organisationMenu}) : super(null);

  final OrganisationContextMenuCubit organisationMenu;

  void active(Organisation organisation) {
    print(organisationMenu.state.where((menu) => menu.action == organisation));
  }
}
