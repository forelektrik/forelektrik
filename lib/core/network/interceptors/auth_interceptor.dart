// lib/core/network/interceptors/auth_interceptor.dart

import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'consumer_key': ApiConstants.consumerKey,
      'consumer_secret': ApiConstants.consumerSecret,
    });

    handler.next(options);
  }
}
