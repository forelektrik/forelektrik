// lib/data/datasources/remote/product_remote_data_source.dart

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';
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
        if (searchQuery != null) ApiConstants.search: searchQuery,
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
      throw _handleError(e);
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _apiClient.get('${ApiConstants.products}/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
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
        'featured': true,
      };

      final response = await _apiClient.get(
        ApiConstants.products,
        queryParameters: queryParameters,
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
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
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is NetworkException) {
      return error;
    } else if (error is ServerException) {
      return error;
    } else if (error is BadRequestException) {
      return error;
    } else if (error is UnauthorizedException) {
      return error;
    } else if (error is NotFoundException) {
      return error;
    } else {
      return UnknownException(message: 'Bilinmeyen bir hata oluştu');
    }
  }
}
