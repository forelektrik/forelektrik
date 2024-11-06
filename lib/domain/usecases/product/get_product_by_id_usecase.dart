// lib/domain/usecases/product/get_product_by_id_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final IProductRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<Either<Failure, Product>> call(int id) async {
    return await repository.getProductById(id);
  }
}
