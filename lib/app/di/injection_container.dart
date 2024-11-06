// lib/app/di/injection.dart

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../domain/usecases/product/get_product_by_id_usecase.dart';
import '../../domain/usecases/product/get_products_by_category_usecase.dart';
import '../../domain/usecases/product/get_products_usecase.dart';
import '../../presentation/bloc/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Blocs
  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      getProductById: sl(),
      getFeaturedProducts: sl(),
      getProductsByCategory: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetFeaturedProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepository(sl(), sl()),
  );

  // Data Sources
  sl.registerLazySingleton<IProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl()),
  );
}
