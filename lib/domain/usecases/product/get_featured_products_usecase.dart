// lib/domain/usecases/product/get_featured_products_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetFeaturedProductsUseCase {
  final IProductRepository repository;

  GetFeaturedProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call({
    int? page,
    int? perPage,
  }) async {
    return await repository.getFeaturedProducts(
      page: page,
      perPage: perPage,
    );
  }
}
