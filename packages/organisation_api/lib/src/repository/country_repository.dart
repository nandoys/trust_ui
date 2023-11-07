import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';

class CountryRepository {
  CountryRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final String? port;

  Future<List<Country>> getCountries() async {
    if (protocol != null && host != null && port != null) {
      final Uri url;
      if (protocol == 'Http') {
        url = Uri.http('$host:$port', '/api/organisation/pays/');
      }
      else {
        url = Uri.https('$host:$port', '/api/organisation/pays/');
      }

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => Country.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

}