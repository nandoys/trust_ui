import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';
import '../models/models.dart';

class UserRepository {
  UserRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<User?> getUser() async {
   return null;
  }

  Future<User?> addAdmin(User user) async {
    if (protocol != null && host != null && port != null) {
      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: 'api/get-started/organisation/utilisateur'
      );

      http.Response response = await http.post(uri,
        body: jsonEncode(user.toJson()), headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return User.fromJson(json);
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }
    return null;
  }

  Future<bool> checkField(Organisation organisation, String field, String value) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organisation/utilisateur/existe',
          queryParameters: {'org_id': organisation.id, 'field': field, 'value': value}
      );

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return json[field] ?? false;
      }
      else {
        print(response.statusCode);
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return false;
  }
}