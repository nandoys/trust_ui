import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';


import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';

class OrganizationContextMenuCubit extends Cubit<List<MenuItem>> {
  OrganizationContextMenuCubit({required this.connectivityStatus,required this.apiStatus})
      : super([MenuItem(title: 'Nouvelle', action: 'create')]);

  final ConnectivityStatusCubit connectivityStatus;
  final OrganizationApiStatusCubit apiStatus;

  void get(OrganizationRepository repository) async {

    try {
      final organizations = await repository.getOrganizations();

      if (organizations != null && organizations.isNotEmpty) {
        List<MenuItem> menus = [MenuItem(title: 'Nouvelle', action: 'create')];

        List<MenuItem> organizationMenu = organizations.map((organization) {
          return MenuItem(title: organization.name, action: organization);
        }).toList();

        menus.addAll(organizationMenu);
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
