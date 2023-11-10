import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';
import 'package:trust_app/utils.dart';

class ActiveOrganisationCubit extends Cubit<Organisation?> {
  ActiveOrganisationCubit({required this.organisationMenu, required this.organisationRepository,
  required this.connectivityStatus, required this.apiStatus, required this.setup}) : super(null);

  final OrganisationContextMenuCubit organisationMenu;
  final OrganisationRepository organisationRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final UserRoleApiStatusCubit apiStatus;
  final SetupOrganisationCubit setup;

  void active(Organisation organisation) async {

    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        apiStatus.changeStatus(ApiStatus.requesting);
        final bool setupStatus = await organisationRepository.isSetupCompleted(organisation);
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

  void setCurrent(Organisation? organisation) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      await organisationRepository.keepInMemory(organisation);
    }
  }

  void getCurrent() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      String? organisationId = await organisationRepository.getOrganisationInMemory();

      Organisation? current;

      for (var menu in organisationMenu.state) {

        if(menu.action is Organisation) {
          final Organisation organisation = menu.action as Organisation;

          if (organisationId == organisation.id) {
            try {
              final bool setupStatus = await organisationRepository.isSetupCompleted(organisation);
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

  void removeCurrent() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      bool isRemoved = await organisationRepository.removeOrganisationInMemory();

      if (isRemoved) {
        emit(null);
      }
    }
  }

}
