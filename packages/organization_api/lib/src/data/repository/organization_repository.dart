import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:organization_api/src/data/models/models.dart';

class OrganizationRepository {
  OrganizationRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;
  
  Future<List<Organization>?> getOrganizations() async {
   if (protocol != null && host != null && port != null) {

     final uri = Uri(
         scheme: protocol?.toLowerCase(),
         host: host,
         port: port,
         path: '/api/organization'
     );

     http.Response response = await http.get(uri);

     if (response.statusCode == 200) {
       final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
       return List.from(json).map((e) => Organization.fromJson(e)).toList();
     } else {
       throw Exception("Quelque chose s'est mal passé");
     }
   }

   return null;
  }

  Future<Organization?> add(Organization organization) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organization/'
      );

      http.Response response = await http.post(uri,
          body: jsonEncode(organization.toJson()), headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
      );

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return Organization.fromJson(json);
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return null;
  }

  Future<bool> isSetupCompleted(Organization organization) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organization/user/exist',
          queryParameters: {'org_id': organization.id, 'field': 'superuser'}
      );

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return json['superuser'] ?? false;
      }
      else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return false;
  }

  Future<bool> keepInMemory(Organization? organization) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (organization != null) {
      prefs.setString('organization', organization.id as String);
      return true;
    }

    return false;
  }

  Future<String?> getOrganizationInMemory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return  prefs.getString('organization');
  }

  Future<bool> removeOrganizationInMemory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return  prefs.remove('organization');
  }

}

class OrganizationTypeRepository {
  OrganizationTypeRepository({required this.protocol, required this.host, required this.port});
  final String? protocol;
  final String? host;
  final int? port;

  Future<List<OrganizationType>> getOrganizationType() async {
    if (protocol != null && host != null && port != null) {
      final Uri url;
      if (protocol == 'Http') {
        url = Uri.http('$host:$port', '/api/organization/type/');
      }
      else {
        url = Uri.https('$host:$port', '/api/organization/type/');
      }

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => OrganizationType.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }
}

