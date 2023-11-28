import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';

class CurrencyCubit extends Cubit<List<Currency>?> {
  CurrencyCubit({required this.repository, required this.connectivityStatus, required this.apiStatus}) : super(null);
  final CurrencyRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final CurrencyApiStatusCubit apiStatus;

  void getCurrencies() async {

    try {
      apiStatus.changeStatus(ApiStatus.requesting);
      List<Currency> response = await repository.getCurrencies();

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

class OrganizationCurrencyCubit extends Cubit<List<Currency>?> {
  OrganizationCurrencyCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(null);

  final CurrencyRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final CurrencyApiStatusCubit apiStatus;

  void getCurrencies(Organization organization) async {
    try {

      apiStatus.changeStatus(ApiStatus.requesting);
      List<Currency> response = await repository.getCurrenciesFor(organization);

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
