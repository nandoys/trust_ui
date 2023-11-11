import 'package:authentication_api/authentication_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_api/organisation_api.dart';
import 'package:server_api/server_api.dart';

import 'package:user_api/user_api.dart';
import 'package:utils/utils.dart';

import 'api_status/api_status_cubit.dart';

class AuthenticationCubit extends Cubit<AuthenticationStatus> {
  AuthenticationCubit({required this.authenticationRepository, required this.connectivityStatus, required this.userCubit,
    required this.apiStatus}) : super(AuthenticationStatus.anonymous);

  final AuthenticationRepository authenticationRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final LoginApiStatusCubit apiStatus;
  final UserCubit userCubit;

  void login(String username, String password, Organisation? organisation) async {

    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        apiStatus.changeStatus(ApiStatus.requesting);
        User? user = await authenticationRepository.logIn(username: username, password: password);

        if (user != null) {
          if (user.organisation == organisation) {
            emit(AuthenticationStatus.authenticated);

            userCubit.loggedUser(user);
          } else {
            emit(AuthenticationStatus.unauthenticated);
            userCubit.loggedUser(null);
          }

        } else {
          emit(AuthenticationStatus.unauthenticated);
          userCubit.loggedUser(null);
        }
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
        userCubit.loggedUser(null);
      }
      on UserNotFound {
        emit(AuthenticationStatus.unauthenticated);
        userCubit.loggedUser(null);
      }
      catch (e) {
        emit(AuthenticationStatus.unauthenticated);
        userCubit.loggedUser(null);
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }
  }
}
