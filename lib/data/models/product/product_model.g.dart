// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      sku: json['sku'] as String,
      price: json['price'] as String,
      regularPrice: json['regularPrice'] as String,
      salePrice: json['salePrice'] as String,
      onSale: json['onSale'] as bool,
      totalSales: (json['totalSales'] as num).toInt(),
      status: json['status'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categoryIds: (json['categoryIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      attributes: json['attributes'] as Map<String, dynamic>,
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      inStock: json['inStock'] as bool,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'sku': instance.sku,
      'price': instance.price,
      'regularPrice': instance.regularPrice,
      'salePrice': instance.salePrice,
      'onSale': instance.onSale,
      'totalSales': instance.totalSales,
      'status': instance.status,
      'images': instance.images,
      'categoryIds': instance.categoryIds,
      'attributes': instance.attributes,
      'stockQuantity': instance.stockQuantity,
      'inStock': instance.inStock,
    };
