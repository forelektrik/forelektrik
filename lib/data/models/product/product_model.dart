// lib/data/models/product/product_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
