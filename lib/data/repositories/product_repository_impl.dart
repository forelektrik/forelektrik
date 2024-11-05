// lib/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../datasources/remote/product_remote_data_source.dart';
import '../../core/network/network_info.dart';

class ProductRepository implements IProductRepository {
  final IProductRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProductRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int? page,
    int? perPage,
    String? searchQuery,
    List<int>? categoryIds,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final products = await _remoteDataSource.getProducts(
          page: page,
          perPage: perPage,
          searchQuery: searchQuery,
          categoryIds: categoryIds,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final product = await _remoteDataSource.getProductById(id);
        return Right(product);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
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
    if (await _networkInfo.isConnected) {
      try {
        final products = await _remoteDataSource.getFeaturedProducts(
          page: page,
          perPage: perPage,
        );
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
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
    if (await _networkInfo.isConnected) {
      try {
        final products = await _remoteDataSource.getProductsByCategory(
          categoryId,
          page: page,
          perPage: perPage,
        );
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }
}
