import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_api/user_api.dart';

import '../../exception.dart';

enum AuthenticationStatus { anonymous, authenticated, unauthenticated }

class AuthenticationRepository {

  AuthenticationRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.anonymous;
    yield* _controller.stream;
  }

  Future<User?> logIn({required String username, required String password}) async {

    if (protocol != null && host != null && port != null) {
      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organisation/utilisateur/login'
      );

      http.Response response = await http.post(
          uri,
          body: jsonEncode({'username': username, 'password': password}),
          headers: {"Content-Type": "application/json; charset=utf-8",}
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        _controller.add(AuthenticationStatus.authenticated);
        return User.fromJson(json);
      }
      else if(response.statusCode == 404) {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw UserNotFound();
      }
      else {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    _controller.add(AuthenticationStatus.unauthenticated);

    return null;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.anonymous);
  }

  void dispose() => _controller.close();

}