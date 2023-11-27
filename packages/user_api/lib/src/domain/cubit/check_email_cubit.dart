import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organization_api/organization_api.dart';
import 'package:user_api/src/data/data.dart';
import 'package:utils/utils.dart';

class CheckEmailCubit extends Cubit<bool> {
  CheckEmailCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(false);

  final UserRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final UserFieldApiStatusCubit apiStatus;

  void checkField(Organization organization, String value) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool isEmailFieldExist = await repository.checkField(organization, 'email', value);
        emit(isEmailFieldExist);
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
