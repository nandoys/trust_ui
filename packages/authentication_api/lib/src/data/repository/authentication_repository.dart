import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_api/user_api.dart';

import '../../exception.dart';

enum AuthenticationStatus { anonymous, authenticated, unauthenticated }

class AuthenticationRepository {

  AuthenticationRepository({required this.protocol, required this.host, required this.port});

  String? protocol;
  String? host;
  int? port;

  Future<User?> logIn({required String username, required String password}) async {

    if (protocol != null && host != null && port != null) {
      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organization/user/login'
      );

      http.Response response = await http.post(
          uri,
          body: jsonEncode({'username': username, 'password': password}),
          headers: {"Content-Type": "application/json; charset=utf-8",}
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return User.fromJson(json);
      }
      else if(response.statusCode == 404) {
        throw UserNotFound();
      }
      else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return null;
  }

  void logOut() {

  }

}