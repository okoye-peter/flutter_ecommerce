// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductVariationModel {
  String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() => ({
    'Id': id,
    'Image': image,
    'Description': description,
    'Price': price,
    'SalePrice': salePrice,
    'AttributeValues': attributeValues,
  });

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: document['Id'] ?? '',
      price: double.parse((document['Price'] ?? 0.0).toString()),
      sku: document['SKU'] ?? '',
      stock: document['stock'] ?? 0,
      salePrice: double.parse((document['SalePrice'] ?? 0.0).toString()),
      image: document['image'] ?? '', 
      attributeValues: Map<String,String>.from(document['AttributeValues']),
    );
  }
}
