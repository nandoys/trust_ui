import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:organization_api/src/data/models/models.dart';

class CountryRepository {
  CountryRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<List<Country>> getCountries() async {
    if (protocol != null && host != null && port != null) {
      final url = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organization/country/'
      );

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