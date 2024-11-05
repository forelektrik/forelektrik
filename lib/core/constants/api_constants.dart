// lib/core/constants/api_constants.dart

class ApiConstants {
  static const String baseUrl = 'https://forelektrik.com/wp-json/wc/v3';
  static const String consumerKey =
      'ck_46b693c5cc01dc220d2428c2e8c75cb096f85545';
  static const String consumerSecret =
      'cs_7576b5a9a720ec4bd34ef27f85ee6e2426b705ed';

  // Endpoints
  static const String products = '/products';
  static const String productCategories = '/products/categories';
  static const String customers = '/customers';
  static const String orders = '/orders';

  // Query Parameters
  static const String perPage = 'per_page';
  static const String page = 'page';
  static const String search = 'search';
  static const String category = 'category';
  static const String status = 'status';
  static const String orderBy = 'orderby';
  static const String order = 'order';
}
