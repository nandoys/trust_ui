import 'dart:convert';
import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/src/data/models/activity_models.dart';
import 'package:http/http.dart' as http;
import 'package:organization_api/organization_api.dart';

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

        return List.from(json).map((jsonProductCategory) => ProductCategory.fromJson(jsonProductCategory)).toList();
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

}

class ProductRepository {
  ProductRepository({required this.protocol, required this.host, required this.port});

  final String? protocol;
  final String? host;
  final int? port;

  Future<List<Product>> get(String? filters, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/'
      );

      http.Response response = await http.get(uri,
        headers: {
          'Authorization':  'Trust $token'
        },
      );

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return List.from(json).map((jsonProduct) => Product.fromJson(jsonProduct)).toList();
      }
      else if (response.statusCode == 401) {
        // HTTP 401 Unauthorized
      }
      else {

        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return [];
  }

  Future<Product?> add(Product product, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/'
      );

      http.Response response = await http.post(uri,
        body: jsonEncode(product.toJson()), headers: {
          "Content-Type": "application/json; charset=utf-8",
          'Authorization':  'Trust $token'
        },
      );

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return Product.fromJson(json);
      } else {

        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return null;
  }

  Future<Product?> createAccount(Product product, String number, String name, Account account, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/account'
      );

      http.Response response = await http.post(uri,
        body: jsonEncode({
          'product_id': product.id,
          'account_id': account.id,
          'account_number': number,
          'account_name': name,
        }), headers: {
          "Content-Type": "application/json; charset=utf-8",
          'Authorization':  'Trust $token'
        },
      );

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        return Product.fromJson(json);
      }
      else if (response.statusCode == 500) {
        final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
        throw json['account'];
      }
      else {

        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return null;
  }

  Future<bool> checkField(Organization organization, String field, String value, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/exist',
          queryParameters: {'org_id': organization.id, 'field': field, 'value': value}
      );

      http.Response response = await http.get(uri, headers: {
        'Authorization':  'Trust $token'
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return json[field];
      }
      else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return false;
  }

  Future<Product> updateByField(Product product, String field, dynamic value, String token) async {
    if (protocol != null && host != null && port != null) {

      final uri = Uri(
          scheme: protocol?.toLowerCase(),
          host: host,
          port: port,
          path: '/api/product/${product.id}/update'
      );

      http.Response response = await http.put(uri,headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization':  'Trust $token'
      },
          body: jsonEncode({field: value})
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return Product.fromJson(json);
      }
      else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }

    return product;
  }
}