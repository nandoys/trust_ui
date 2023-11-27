import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

class OrganizationCubit extends Cubit<Organization?> {
  OrganizationCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(null);

  final OrganizationRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final OrganizationApiStatusCubit apiStatus;

  void create(Organization organization) async {
    try {
      apiStatus.changeStatus(ApiStatus.requesting);
      Organization? response = await repository.add(organization);

       emit(response);

      if (connectivityStatus.state == ConnectivityStatus.disconnected){
        connectivityStatus.changeStatus(ConnectivityStatus.connected);
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


class SelectedOrganizationTypeCubit extends Cubit<OrganizationType?> {
  SelectedOrganizationTypeCubit() : super(null);

  void change(OrganizationType? type) {
    emit(type);
  }
}


class OrganizationTypeMenuCubit extends Cubit<List<OrganizationType>> {
  OrganizationTypeMenuCubit({required this.repository, required this.connectivityStatus,
    required this.apiStatus}) : super([]);

  final OrganizationTypeRepository repository;

  final ConnectivityStatusCubit connectivityStatus;
  final OrganizationTypeApiStatusCubit apiStatus;

  void getAll() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final typeOrganisation = await repository.getOrganizationType();
        emit(typeOrganisation);
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
      }
      catch (e) {
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }
  }
}

