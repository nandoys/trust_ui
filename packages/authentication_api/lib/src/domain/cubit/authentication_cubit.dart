import 'package:authentication_api/authentication_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';

import 'package:user_api/user_api.dart';
import 'package:utils/utils.dart';

class AuthenticationCubit extends Cubit<AuthenticationStatus> {
  AuthenticationCubit({required this.connectivityStatus, required this.userCubit, required this.apiStatus,
    required this.server}) : super(AuthenticationStatus.anonymous);

  final ConnectivityStatusCubit connectivityStatus;
  final LoginApiStatusCubit apiStatus;
  final UserCubit userCubit;
  final ActiveServerCubit server;


  void login(String username, String password, Organization? organization, AuthenticationRepository repository) async {
    apiStatus.changeStatus(ApiStatus.requesting);

    if (connectivityStatus.state == ConnectivityStatus.disconnected) {
      apiStatus.changeStatus(ApiStatus.failed);
      server.get();
    }

    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        User? user = await repository.logIn(username: username, password: password);

        apiStatus.changeStatus(ApiStatus.succeeded);

        if (user != null) {

          if (user.organization == organization) {
            emit(AuthenticationStatus.authenticated);

            userCubit.loggedUser(user);
          } else {
            emit(AuthenticationStatus.unauthenticated);
            userCubit.loggedUser(null);
          }
        }
      }
      on http.ClientException {
        emit(AuthenticationStatus.anonymous);
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
        userCubit.loggedUser(null);
        apiStatus.changeStatus(ApiStatus.failed);
      }
      on UserNotFound {
        emit(AuthenticationStatus.unauthenticated);
        userCubit.loggedUser(null);
        apiStatus.changeStatus(ApiStatus.succeeded);
      }
      catch (e) {
        emit(AuthenticationStatus.anonymous);
        userCubit.loggedUser(null);
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }

  }
}
