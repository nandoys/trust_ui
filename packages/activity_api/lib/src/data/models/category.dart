
enum ProductType { bien, service, mixte }

class ProductCategory {

  ProductCategory({required this.id, required this.name, required this.productType});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    ProductType productType = ProductType.mixte;
    if(json['type_produit'].toString().contains('bien')) {
      productType = ProductType.bien;
    }
    else if(json['type_produit'].toString().contains('service')) {
      productType = ProductType.service;
    }

    return ProductCategory(id: json['id'], name: json['nom'], productType: productType);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'intitule': name, 'type_produit': productType.name,};

    return data;

  }

  final String id;
  final String name;
  final ProductType productType;

}