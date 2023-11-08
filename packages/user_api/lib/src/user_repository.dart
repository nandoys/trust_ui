import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';
import 'models/models.dart';

class UserRepository {
  UserRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<User?> getUser() async {
   return null;
  }

  Future<bool> isSetupCompleted(Organisation organisation) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organisation/utilisateur/existe',
          queryParameters: {'org_id': organisation.id, 'field': 'superuser'}
      );

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return json['superuser'] ?? false;
      }
      else {
        print(response.statusCode);
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return false;
  }
}