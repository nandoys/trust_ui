import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';
import 'package:trust_app/utils.dart';

class CountryMenuCubit extends Cubit<List<Country>> {
  CountryMenuCubit({required this.countryRepository, required this.connectivityStatus, required this.apiStatus})
      : super([]);

  final CountryRepository countryRepository;

  final ConnectivityStatusCubit connectivityStatus;
  final CountryApiStatusCubit apiStatus;

  void getAll() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final countries = await countryRepository.getCountries();
        emit(countries);
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
