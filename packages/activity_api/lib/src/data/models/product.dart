import 'package:activity_api/src/data/data.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:tax_api/tax_api.dart';

class Product {
  Product({this.id, required this.organisation, required this.name, this.buyPrice, this.sellPrice, this.sellPromoPrice,
    required this.currency, this.inPromo = false, required this.productCategory, this.canPerish = false, this.taxes});

  final String? id;
  final Organisation organisation;
  final String name;
  final double? buyPrice;
  final double? sellPrice;
  final double? sellPromoPrice;
  final Currency currency;
  final bool inPromo;
  final ProductCategory productCategory;
  final bool canPerish;
  final List<Tax>? taxes;


}