import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:organization_api/organization_api.dart';

class CurrencyRepository {
  CurrencyRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<List<Currency>> getCurrencies(String token) async {
    if (protocol != null && host != null && port != null) {

      final url = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/settings/currency/'
      );

      http.Response response = await http.get(url, headers: {
        'Authorization':  'Trust $token'
      });

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => Currency.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

  Future<List<Currency>> getOrganizationCurrencies(Organization organization, String token) async {
    if (protocol != null && host != null && port != null) {

      final url = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/organization/currency',
          queryParameters: {'org_id': organization.id}
      );

      http.Response response = await http.get(url, headers: {
        'Authorization':  'Trust $token'
      });

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => Currency.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

}