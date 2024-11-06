// lib/presentation/bloc/product/product_event.dart

import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final int? page;
  final int? perPage;
  final String? searchQuery;
  final List<int>? categoryIds;
  final String? sortBy;
  final String? sortOrder;

  const GetProductsEvent({
    this.page,
    this.perPage,
    this.searchQuery,
    this.categoryIds,
    this.sortBy,
    this.sortOrder,
  });

  @override
  List<Object?> get props => [
        page,
        perPage,
        searchQuery,
        categoryIds,
        sortBy,
        sortOrder,
      ];
}

class GetProductEvent extends ProductEvent {
  final int id;

  const GetProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetFeaturedProductsEvent extends ProductEvent {
  final int? page;
  final int? perPage;

  const GetFeaturedProductsEvent({
    this.page,
    this.perPage,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class GetProductsByCategoryEvent extends ProductEvent {
  final int categoryId;
  final int? page;
  final int? perPage;

  const GetProductsByCategoryEvent(
    this.categoryId, {
    this.page,
    this.perPage,
  });

  @override
  List<Object?> get props => [categoryId, page, perPage];
}
