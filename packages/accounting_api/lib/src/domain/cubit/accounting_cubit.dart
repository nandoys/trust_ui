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

  Future<void> checkAccount({required Organization organization, required String number, required String token}) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool isAccountExist = await repository.check(organization, number, token);
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

class UpdateAccountCubit extends Cubit<bool?> {
  UpdateAccountCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(null);

  final AccountRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final UpdateAccountApiStatusCubit apiStatus;

  Future<void> update({required String field, required Account account, required String token}) async {
    apiStatus.changeStatus(ApiStatus.requesting);
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final Account? response = await repository.update(field, account, token);
        apiStatus.changeStatus(ApiStatus.succeeded);
        emit(response != null);
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
        apiStatus.changeStatus(ApiStatus.failed);
      }
      catch (e) {
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }
    else if (connectivityStatus.state == ConnectivityStatus.disconnected) {
      apiStatus.changeStatus(ApiStatus.failed);
      throw Exception('Aucune connexion');
    }

  }

  void setNull() {
    emit(null);
  }
}

class DeleteAccountCubit extends Cubit<bool?> {
  DeleteAccountCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(null);

  final AccountRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final DeleteAccountApiStatusCubit apiStatus;

  Future<void> delete({required Account account, required String token}) async {
    apiStatus.changeStatus(ApiStatus.requesting);
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool response = await repository.delete(account, token);
        apiStatus.changeStatus(ApiStatus.succeeded);
        emit(response);
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
        apiStatus.changeStatus(ApiStatus.failed);
      }
      catch (e) {
        apiStatus.changeStatus(ApiStatus.failed);
        print(e);
      }
    }
    else if (connectivityStatus.state == ConnectivityStatus.disconnected) {
      apiStatus.changeStatus(ApiStatus.failed);
      throw Exception('Aucune connexion');
    }

  }

  void setNull() {
    emit(null);
  }
}