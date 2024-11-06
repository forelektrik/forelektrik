// lib/presentation/bloc/product/product_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/product/get_products_usecase.dart';
import '../../../domain/usecases/product/get_product_by_id_usecase.dart';
import '../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../domain/usecases/product/get_products_by_category_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProducts;
  final GetProductByIdUseCase getProductById;
  final GetFeaturedProductsUseCase getFeaturedProducts;
  final GetProductsByCategoryUseCase getProductsByCategory;

  ProductBloc({
    required this.getProducts,
    required this.getProductById,
    required this.getFeaturedProducts,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductByIdEvent>(_onGetProductById);
    on<GetFeaturedProductsEvent>(_onGetFeaturedProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProducts(
      page: event.page,
      perPage: event.perPage,
      searchQuery: event.searchQuery,
      categoryIds: event.categoryIds,
      sortBy: event.sortBy,
      sortOrder: event.sortOrder,
    );

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }

  Future<void> _onGetProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProductById(event.id);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }

  Future<void> _onGetFeaturedProducts(
    GetFeaturedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getFeaturedProducts(
      page: event.page,
      perPage: event.perPage,
    );

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProductsByCategory(
      event.categoryId,
      page: event.page,
      perPage: event.perPage,
    );

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }
}
