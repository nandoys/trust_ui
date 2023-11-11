import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:user_api/src/data/data.dart';
import 'package:user_api/src/domain/domain.dart';
import 'package:utils/utils.dart';

class UserCubit extends Cubit<User?> {
  UserCubit({required this.userRepository, required this.connectivityStatus, required this.apiStatus}) : super(null);

  final UserRepository userRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final UserApiStatusCubit apiStatus;

  void createAdminUser(User user) async {
    try {
      apiStatus.changeStatus(ApiStatus.requesting);
      User? response = await userRepository.addAdmin(user);

      if (response != null) {
        emit(response);
      } else {
        emit(null);
      }

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

  void loggedUser(User? user) {
    emit(user);
  }
}
