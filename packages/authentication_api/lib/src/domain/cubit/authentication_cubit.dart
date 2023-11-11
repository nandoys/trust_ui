import 'package:authentication_api/authentication_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:user_api/user_api.dart';

class AuthenticationCubit extends Cubit<AuthenticationStatus> {
  AuthenticationCubit({required this.authenticationRepository}) : super(AuthenticationStatus.anonymous);

  final AuthenticationRepository authenticationRepository;

  void login(String username, String password) async {
    try {
      User? user = await authenticationRepository.logIn(username: username, password: password);

      if (user != null) {
        emit(AuthenticationStatus.authenticated);
      } else {
        emit(AuthenticationStatus.unauthenticated);
      }
    }
    on http.ClientException {

    }
    on UserNotFound {
      emit(AuthenticationStatus.unauthenticated);
    }
    catch (e) {
      emit(AuthenticationStatus.unauthenticated);
    }
  }
}
