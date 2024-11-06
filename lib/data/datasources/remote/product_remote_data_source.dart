// lib/data/datasources/remote/product_remote_data_source.dart

import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/product/product_model.dart';

abstract class IProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  });

  Future<ProductModel> getProductById(int id);

  Future<List<ProductModel>> getFeaturedProducts({
    int? page,
    int? perPage,
  });

  Future<List<ProductModel>> getProductsByCategory(
    int categoryId, {
    int? page,
    int? perPage,
  });
}

class ProductRemoteDataSource implements IProductRemoteDataSource {
  final ApiClient _apiClient;

  ProductRemoteDataSource(this._apiClient);

  @override
  Future<List<ProductModel>> getProducts({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) ApiConstants.page: page,
        if (perPage != null) ApiConstants.perPage: perPage,
        if (searchQuery != null && searchQuery.isNotEmpty)
          ApiConstants.search: searchQuery,
        if (categoryIds != null && categoryIds.isNotEmpty)
          ApiConstants.category: categoryIds.join(','),
        if (sortBy != null) ApiConstants.orderBy: sortBy,
        if (sortOrder != null) ApiConstants.order: sortOrder,
      };

      final response = await _apiClient.get(
        ApiConstants.products,
        queryParameters: queryParameters,
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.products}/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts({
    int? page,
    int? perPage,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) ApiConstants.page: page,
        if (perPage != null) ApiConstants.perPage: perPage,
        ApiConstants.featured: true,
      };

      final response = await _apiClient.get(
        ApiConstants.products,
        queryParameters: queryParameters,
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(
    int categoryId, {
    int? page,
    int? perPage,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) ApiConstants.page: page,
        if (perPage != null) ApiConstants.perPage: perPage,
        ApiConstants.category: categoryId,
      };

      final response = await _apiClient.get(
        ApiConstants.products,
        queryParameters: queryParameters,
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
