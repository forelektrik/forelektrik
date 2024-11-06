// lib/domain/entities/product.dart

class Product {
  final int id;
  final String name;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final int totalSales;
  final String status;
  final List<String> images;
  final List<int> categoryIds;
  final Map<String, dynamic> attributes;
  final int stockQuantity;
  final bool inStock;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.totalSales,
    required this.status,
    required this.images,
    required this.categoryIds,
    required this.attributes,
    required this.stockQuantity,
    required this.inStock,
  });
}
