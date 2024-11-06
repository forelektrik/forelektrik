// lib/domain/usecases/product/get_products_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductsUseCase {
  final IProductRepository repository;

  const GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  }) async {
    return await repository.getProducts(
      page: page,
      perPage: perPage,
      searchQuery: searchQuery,
      categoryIds: categoryIds,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }
}
