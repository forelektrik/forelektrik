// lib/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_remote_data_source.dart';

class ProductRepository implements IProductRepository {
  final IProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepository(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts(
          page: page,
          perPage: perPage,
          searchQuery: searchQuery,
          categoryIds: categoryIds,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );
        return Right(products);
      } catch (e) {
        return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        return Right(product);
      } catch (e) {
        return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts({
    int? page,
    int? perPage,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getFeaturedProducts(
          page: page,
          perPage: perPage,
        );
        return Right(products);
      } catch (e) {
        return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    int categoryId, {
    int? page,
    int? perPage,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategory(
          categoryId,
          page: page,
          perPage: perPage,
        );
        return Right(products);
      } catch (e) {
        return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }
}
