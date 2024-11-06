// lib/domain/usecases/product/get_products_by_category_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final IProductRepository repository;

  const GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(
    int categoryId, {
    int? page,
    int? perPage,
  }) async {
    return await repository.getProductsByCategory(
      categoryId,
      page: page,
      perPage: perPage,
    );
  }
}
