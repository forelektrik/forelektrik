// lib/core/constants/api_constants.dart

class ApiConstants {
  static const String baseUrl = 'https://forelektrik.com/wp-json/wc/v3';
  static const String consumerKey = 'YOUR_CONSUMER_KEY';
  static const String consumerSecret = 'YOUR_CONSUMER_SECRET';

  // Endpoints
  static const String products = '/products';
  static const String categories = '/products/categories';
  static const String orders = '/orders';
  static const String customers = '/customers';

  // Query Parameters
  static const String perPage = 'per_page';
  static const String page = 'page';
  static const String search = 'search';
  static const String category = 'category';
  static const String featured = 'featured';
  static const String status = 'status';
  static const String orderBy = 'orderby';
  static const String order = 'order';
}
