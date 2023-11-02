import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/server/server_cubit.dart';
import 'package:trust_app/home/logic/cubit/organisation/api_status/api_status_cubit.dart';
import 'package:trust_app/utils.dart';

class CountryMenuCubit extends Cubit<List<DropdownMenuEntry<dynamic>>> {
  CountryMenuCubit({required this.countryRepository, required this.connectivityStatus, required this.apiStatus})
      : super([]);

  final CountryRepository countryRepository;

  final ConnectivityStatusCubit connectivityStatus;
  final CountryApiStatusCubit apiStatus;

  void getAll() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final countries = await countryRepository.getCountries();

        if (countries != null && countries.isNotEmpty) {
          List<DropdownMenuEntry<dynamic>> menus = countries.map((country) {
            return DropdownMenuEntry(value: country.id, label: country.name);
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
