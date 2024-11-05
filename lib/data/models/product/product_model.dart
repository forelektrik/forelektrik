// lib/data/models/product/product_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.shortDescription,
    required super.sku,
    required super.price,
    required super.regularPrice,
    required super.salePrice,
    required super.onSale,
    required super.totalSales,
    required super.status,
    required super.images,
    required super.categoryIds,
    required super.attributes,
    required super.stockQuantity,
    required super.inStock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['short_description'] as String,
      sku: json['sku'] as String,
      price: json['price'] as String,
      regularPrice: json['regular_price'] as String,
      salePrice: json['sale_price'] as String? ?? '',
      onSale: json['on_sale'] as bool,
      totalSales: json['total_sales'] as int? ?? 0,
      status: json['status'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e['src'] as String)
          .toList(),
      categoryIds: (json['categories'] as List<dynamic>)
          .map((e) => e['id'] as int)
          .toList(),
      attributes: json['attributes'] as Map<String, dynamic>? ?? {},
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      inStock: json['in_stock'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
