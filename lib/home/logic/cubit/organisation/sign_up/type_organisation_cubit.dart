import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/home/logic/cubit/server/server_cubit.dart';
import 'package:trust_app/home/logic/cubit/organisation/api_status/api_status_cubit.dart';
import 'package:trust_app/utils.dart';

class TypeOrganisationMenuCubit extends Cubit<List<DropdownMenuEntry<dynamic>>> {
  TypeOrganisationMenuCubit({required this.typeOrganisationRepository, required this.connectivityStatus,
  required this.apiStatus}) : super([]);

  final TypeOrganisationRepository typeOrganisationRepository;

  final ConnectivityStatusCubit connectivityStatus;
  final TypeOrganisationApiStatusCubit apiStatus;

  void getAll() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final typeOrganisation = await typeOrganisationRepository.getTypeOrganisation();

        if (typeOrganisation != null && typeOrganisation.isNotEmpty) {
          List<DropdownMenuEntry<dynamic>> menus = typeOrganisation.map((type) {
            return DropdownMenuEntry(value: type.id, label: type.name);
          }).toList();

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
}
