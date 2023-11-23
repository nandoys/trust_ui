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
      final Uri url;
      if (protocol == 'Http') {
        url = Uri.http('$host:$port', '/api/config/categorie/produit/');
      }
      else {
        url = Uri.https('$host:$port', '/api/config/categorie/produit/');
      }

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
  Future<List<Module>> getModulesBy(String id) async {
    if (protocol != null && host != null && port != null) {
      final Uri url;
      if (protocol == 'Http') {
        url = Uri.http(
            '$host:$port',
            '/api/config/categorie/produit/',
            {'categorie_produit': id}
        );
      }
      else {
        url = Uri.https(
            '$host:$port',
            '/api/config/categorie/produit/',
            {'categorie_produit': id}
        );
      }

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
}