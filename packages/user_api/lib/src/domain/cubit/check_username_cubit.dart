import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:user_api/src/data/data.dart';
import 'package:utils/utils.dart';

class CheckUsernameCubit extends Cubit<bool> {
  CheckUsernameCubit({required this.userRepository, required this.connectivityStatus, required this.apiStatus})
      : super(false);

  final UserRepository userRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final UserFieldApiStatusCubit apiStatus;

  void checkField(Organisation organisation, String value) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool isUserFieldExist = await userRepository.checkField(organisation, 'username', value);
        emit(isUserFieldExist);
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
