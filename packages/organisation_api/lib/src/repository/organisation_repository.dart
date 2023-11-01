import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';

class OrganisationRepository {
  OrganisationRepository({required this.protocol, required this.host, required this.port}) {}

  final String? protocol;
  final String? host;
  final String? port;
  
  Future<List<Organisation>?> getOrganisations() async {
   if (protocol != null && host != null && port != null) {
     final Uri url;
     if (protocol == 'Http') {
       url = Uri.http('$host:$port', '/api/organisation');
     }
     else {
       url = Uri.https('$host:$port', '/api/organisation');
     }

     http.Response response = await http.get(url);

     if (response.statusCode == 200) {
       final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
       return List.from(json).map((e) => Organisation.fromJson(e)).toList();
     } else {
       throw Exception("Quelque chose s'est mal passé");
     }
   }

   return null;
  }

}

