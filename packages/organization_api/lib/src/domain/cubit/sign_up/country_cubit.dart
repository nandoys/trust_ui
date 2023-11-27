import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

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

class SelectedCountryCubit extends Cubit<Country?> {
  SelectedCountryCubit() : super(null);

  void change(Country? country) {
    emit(country);
  }
}
