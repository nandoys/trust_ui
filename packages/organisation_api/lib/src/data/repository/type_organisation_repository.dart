import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organisation_api/src/data/models/models.dart';

class TypeOrganisationRepository {
  TypeOrganisationRepository({required this.protocol, required this.host, required this.port});
  final String? protocol;
  final String? host;
  final int? port;

  Future<List<TypeOrganisation>> getTypeOrganisation() async {
    if (protocol != null && host != null && port != null) {
      final Uri url;
      if (protocol == 'Http') {
        url = Uri.http('$host:$port', '/api/organisation/type/');
      }
      else {
        url = Uri.https('$host:$port', '/api/organisation/type/');
      }

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => TypeOrganisation.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }
}