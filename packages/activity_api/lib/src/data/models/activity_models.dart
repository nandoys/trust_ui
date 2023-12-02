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

  factory Product.fromJson(Map<String, dynamic> json) {

    final double? buyPrice = json['buy_price'] == null ? json['buy_price'] : double.tryParse(json['buy_price']);
    final double? sellPrice = json['sell_price'] == null ? json['sell_price'] : double.tryParse(json['sell_price']);
    final double? sellPromoPrice = json['sell_in_promo'] == null ? json['sell_in_promo'] : double.tryParse(json['sell_in_promo']);
    final reference = json['reference'] == null ? null : json['reference'];

    // on createProduct method we use Model object instead of Map
    // so we need to check the runtimeType
    final organization = json['organization'].runtimeType == Organization ? json['organization']
        : Organization.fromJson(json['organization']);
    final currency = json['currency'].runtimeType == Currency ? json['currency'] : Currency.fromJson(json['currency']);
    final productCategory = json['product_category'].runtimeType == ProductCategory ? json['product_category'] :
    ProductCategory.fromJson(json['product_category']);
    final accounts = json['accounts'] == null ? null : List.from(json['accounts']).map((accountJson) => Account.fromJson(accountJson)).toList();
    final taxes = json['taxes'] == null ? null : List.from(json['taxes']).map((taxJson) => Tax.fromJson(taxJson)).toList();

    return Product(id: json['id'], organization: organization, name: json['name'], reference: reference,
        barCode: json['bar_code'], image: json['image'], buyPrice: buyPrice, sellPrice: sellPrice,
        sellPromoPrice: sellPromoPrice, currency: currency, inPromo: json['in_promo'], canPerish: json['can_perish'],
        productCategory: productCategory, accounts: accounts, taxes: taxes);
  }

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

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'name': name, 'organization': organization.id, 'reference': reference,
      'barcode': barCode, 'buying_price': buyPrice, 'selling_price': sellPrice, 'sell_in_promo': sellPromoPrice,
      'currency': currency.id, 'in_promo': inPromo, 'product_category': productCategory.id, 'can_perish': canPerish
    };

    return data;

  }


}