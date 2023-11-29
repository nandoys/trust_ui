import 'package:accounting_api/accounting_api.dart';
import 'package:equatable/equatable.dart';
import 'package:organization_api/organization_api.dart';
import 'package:tax_api/tax_api.dart';

enum ProductType { bien, service, mixte }

class ProductCategory extends Equatable {

  ProductCategory({required this.id, required this.name, required this.productType});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    ProductType productType = ProductType.mixte;
    if(json['product_type'].toString().contains('bien')) {
      productType = ProductType.bien;
    }
    else if(json['product_type'].toString().contains('service')) {
      productType = ProductType.service;
    }

    return ProductCategory(id: json['id'], name: json['name'], productType: productType);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'name': name, 'product_type': productType.name,};

    return data;

  }

  final String id;
  final String name;
  final ProductType productType;

  @override
  List<Object?> get props => [name];

}

class Product extends Equatable {
  Product({this.id, required this.organization, required this.name, this.reference, this.barCode, this.image,
    this.buyPrice, this.sellPrice, this.sellPromoPrice, required this.currency, this.inPromo = false,
    required this.productCategory, this.canPerish = false, this.accounts, this.taxes});

  final String? id;
  final Organization organization;
  final String name;
  final String? reference;
  final String? barCode;
  final String? image;
  final double? buyPrice;
  final double? sellPrice;
  final double? sellPromoPrice;
  final Currency currency;
  final bool inPromo;
  final ProductCategory productCategory;
  final bool canPerish;
  final List<Account>? accounts;
  final List<Tax>? taxes;

  @override
  List<Object?> get props => [id];


}