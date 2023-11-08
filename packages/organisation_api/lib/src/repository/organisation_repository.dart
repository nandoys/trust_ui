import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';

class OrganisationRepository {
  OrganisationRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;
  
  Future<List<Organisation>?> getOrganisations() async {
   if (protocol != null && host != null && port != null) {
     final uri = Uri(
         scheme: protocol?.toLowerCase(),
         host: host,
         port: port,
         path: '/api/organisation'
     );

     http.Response response = await http.get(uri);

     if (response.statusCode == 200) {
       final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
       return List.from(json).map((e) => Organisation.fromJson(e)).toList();
     } else {
       throw Exception("Quelque chose s'est mal passé");
     }
   }

   return null;
  }

  Future<Organisation?> add(Organisation organisation) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organisation/'
      );

      http.Response response = await http.post(uri,
          body: jsonEncode(organisation.toJson()), headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return Organisation.fromJson(json);
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

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

