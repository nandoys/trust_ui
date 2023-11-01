import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class OrganisationContextMenuCubit extends Cubit<List<MenuItem>> {
  OrganisationContextMenuCubit({required this.organisationRepository, required this.activeOrganisation,
  required this.connectivityStatus, }) : super([MenuItem(title: 'Nouvelle', action: 'create')]);

  final OrganisationRepository organisationRepository;
  final ActiveOrganisationCubit activeOrganisation;
  final ConnectivityStatusCubit connectivityStatus;

  void get() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final organisations = await organisationRepository.getOrganisations();
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
      }
      catch (e) {
        print('tr');
      }
    }
  }

  void add(Organisation organisation) {

  }

}
