// lib/core/network/api_client.dart

import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        queryParameters: {
          'consumer_key': ApiConstants.consumerKey,
          'consumer_secret': ApiConstants.consumerSecret,
        },
      ),
    );
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException(message: 'Bağlantı zaman aşımına uğradı');
        case DioExceptionType.badResponse:
          return _handleResponseError(error.response?.statusCode);
        case DioExceptionType.cancel:
          return RequestCancelledException(message: 'İstek iptal edildi');
        default:
          return UnknownException(message: 'Bilinmeyen bir hata oluştu');
      }
    }
    return UnknownException(message: 'Bilinmeyen bir hata oluştu');
  }

  Exception _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return BadRequestException(message: 'Geçersiz istek');
      case 401:
        return UnauthorizedException(message: 'Yetkisiz erişim');
      case 403:
        return ForbiddenException(message: 'Erişim reddedildi');
      case 404:
        return NotFoundException(message: 'Kaynak bulunamadı');
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(message: 'Sunucu hatası');
      default:
        return UnknownException(message: 'Bilinmeyen bir hata oluştu');
    }
  }
}
