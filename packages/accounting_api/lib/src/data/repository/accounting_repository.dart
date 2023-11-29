import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:accounting_api/accounting_api.dart';

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