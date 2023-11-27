import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

class ActiveOrganizationCubit extends Cubit<Organization?> {
  ActiveOrganizationCubit({required this.organizationMenu, required this.connectivityStatus,  required this.setup,
    required this.apiStatus}) : super(null);

  final OrganizationContextMenuCubit organizationMenu;
  final ConnectivityStatusCubit connectivityStatus;
  final UserRoleApiStatusCubit apiStatus;
  final SetupOrganizationCubit setup;

  void active(Organization organization, OrganizationRepository repository) async {

    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        apiStatus.changeStatus(ApiStatus.requesting);
        final bool setupStatus = await repository.isSetupCompleted(organization);
        if (setupStatus) {
          emit(organization);
          setup.emit(null);
        } else {
          emit(null);
          setup.emit(organization);
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

  void setCurrent(Organization? organization, OrganizationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      await repository.keepInMemory(organization);
    }
  }

  void getCurrent(OrganizationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      String? organizationId = await repository.getOrganizationInMemory();

      Organization? current;

      for (var menu in organizationMenu.state) {

        if(menu.action is Organization) {
          final Organization organization = menu.action as Organization;

          if (organizationId == organization.id) {
            try {
              final bool setupStatus = await repository.isSetupCompleted(organization);
              if (setupStatus) {
                current = organization;
              }
            }
            on http.ClientException {
              connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
            }
            catch (e) {
              apiStatus.changeStatus(ApiStatus.failed);
            }

            break;
          }
        }
      }

      emit(current);
    }
  }

  void removeCurrent(OrganizationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      bool isRemoved = await repository.removeOrganizationInMemory();

      if (isRemoved) {
        emit(null);
      }
    }
  }

}
