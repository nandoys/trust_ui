import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:utils/utils.dart';

class ActiveOrganisationCubit extends Cubit<Organisation?> {
  ActiveOrganisationCubit({required this.organisationMenu, required this.connectivityStatus,  required this.setup,
    required this.apiStatus}) : super(null);

  final OrganisationContextMenuCubit organisationMenu;
  final ConnectivityStatusCubit connectivityStatus;
  final UserRoleApiStatusCubit apiStatus;
  final SetupOrganisationCubit setup;

  void active(Organisation organisation, OrganisationRepository repository) async {

    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        apiStatus.changeStatus(ApiStatus.requesting);
        final bool setupStatus = await repository.isSetupCompleted(organisation);
        if (setupStatus) {
          emit(organisation);
          setup.emit(null);
        } else {
          emit(null);
          setup.emit(organisation);
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

  void setCurrent(Organisation? organisation, OrganisationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      await repository.keepInMemory(organisation);
    }
  }

  void getCurrent(OrganisationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      String? organisationId = await repository.getOrganisationInMemory();

      Organisation? current;

      for (var menu in organisationMenu.state) {

        if(menu.action is Organisation) {
          final Organisation organisation = menu.action as Organisation;

          if (organisationId == organisation.id) {
            try {
              final bool setupStatus = await repository.isSetupCompleted(organisation);
              if (setupStatus) {
                current = organisation;
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

  void removeCurrent(OrganisationRepository repository) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      bool isRemoved = await repository.removeOrganisationInMemory();

      if (isRemoved) {
        emit(null);
      }
    }
  }

}
