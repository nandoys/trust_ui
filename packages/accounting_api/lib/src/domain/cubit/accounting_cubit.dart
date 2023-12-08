import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:accounting_api/src/data/data.dart';
import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';

import 'package:accounting_api/src/domain/cubit/api_status/api_status_cubit.dart';

class CheckAccountCubit extends Cubit<bool> {
  CheckAccountCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(false);

  final AccountRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final CheckAccountApiStatusCubit apiStatus;

  void checkAccount({required Organization organization, required String number, required String token}) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool isAccountExist = await repository.checkAccount(organization, number, token);
        emit(isAccountExist);
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