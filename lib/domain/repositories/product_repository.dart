// lib/domain/repositories/product_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class IProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  });

  Future<Either<Failure, Product>> getProductById(int id);

  Future<Either<Failure, List<Product>>> getFeaturedProducts({
    int? page,
    int? perPage,
  });

  Future<Either<Failure, List<Product>>> getProductsByCategory(
    int categoryId, {
    int? page,
    int? perPage,
  });
}
