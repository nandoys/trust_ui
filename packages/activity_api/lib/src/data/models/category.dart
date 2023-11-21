
enum ProductType { bien, service, mixte }

class ProductCategory {

  ProductCategory({this.id, required this.name, required this.productType});

  final String? id;
  final String name;
  final ProductType productType;

}