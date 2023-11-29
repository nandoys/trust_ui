import 'dart:convert';
import 'package:activity_api/src/data/models/activity_models.dart';
import 'package:http/http.dart' as http;

class ProductCategoryRepository {
  ProductCategoryRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<List<ProductCategory>> getProductCategories(String token) async {
    if (protocol != null && host != null && port != null) {

      final url = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/category/',
      );

      http.Response response = await http.get(url,  headers: {
        'Authorization':  'Trust $token'
      });

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));

        return List.from(json).map((e) => ProductCategory.fromJson(e)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }
}