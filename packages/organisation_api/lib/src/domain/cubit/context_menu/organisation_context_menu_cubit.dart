import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';


import 'package:organisation_api/organisation_api.dart';
import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';

class OrganisationContextMenuCubit extends Cubit<List<MenuItem>> {
  OrganisationContextMenuCubit({required this.connectivityStatus,required this.apiStatus})
      : super([MenuItem(title: 'Nouvelle', action: 'create')]);

  final ConnectivityStatusCubit connectivityStatus;
  final OrganisationApiStatusCubit apiStatus;

  void get(OrganisationRepository repository) async {

    try {
      final organisations = await repository.getOrganisations();

      if (organisations != null && organisations.isNotEmpty) {
        List<MenuItem> menus = [MenuItem(title: 'Nouvelle', action: 'create')];

        List<MenuItem> organisationMenu = organisations.map((organisation) {
          return MenuItem(title: organisation.name, action: organisation);
        }).toList();

        menus.addAll(organisationMenu);
        emit(menus);
        apiStatus.changeStatus(ApiStatus.succeeded);
      }

    }
    on http.ClientException {
      connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
    }
    catch (e) {
      apiStatus.changeStatus(ApiStatus.failed);
    }
  }

}
