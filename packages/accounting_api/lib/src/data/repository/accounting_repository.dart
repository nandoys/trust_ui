import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:accounting_api/accounting_api.dart';
import 'package:organization_api/organization_api.dart';

class ModuleRepository {
  ModuleRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<List<Module>> getModules() async {
    if (protocol != null && host != null && port != null) {

      final url = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/category/config',
      );

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => Module.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

  /// Retrieve modules by id filter
  /// don't use this method, the api
  Future<List<Module>> getModulesBy(String id, String token) async {
    if (protocol != null && host != null && port != null) {
      final url = Uri(
        scheme: protocol?.toLowerCase(),
        host: host,
        port: port,
        path: '/api/product/category/config',
        queryParameters: {'product_category': id}
      );

      http.Response response = await http.get(url, headers: {
        'Authorization':  'Trust $token'
      });

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((e) => Module.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }
}

class AccountRepository {
  AccountRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<bool> checkAccount(Organization organization, String number, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/accounting/account/exist',
          queryParameters: {'org_id': organization.id, 'number': number}
      );

      http.Response response = await http.get(uri,
        headers: {
        'Authorization':  'Trust $token'
        },
      );

      if (response.statusCode == 200) {
        final bool json = jsonDecode(utf8.decode(response.bodyBytes));
        return json;
      }
      else {
        print(response.statusCode);
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return false;
  }
}