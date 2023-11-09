import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:user_api/user_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/utils.dart';

class UserAdminCubit extends Cubit<User?> {
  UserAdminCubit({required this.userRepository, required this.connectivityStatus, required this.apiStatus})
      : super(null);

  final UserRepository userRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final CreateAdminUserApiStatusCubit apiStatus;

  void create(User user) async {
    try {
      User? response = await userRepository.add(user);

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
}
