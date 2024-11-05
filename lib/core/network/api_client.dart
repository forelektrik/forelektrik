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
        headers: {
          'Accept': 'application/json',
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
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
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
          return NetworkException(message: 'Bağlantı zaman aşımına uğradı');
        case DioExceptionType.sendTimeout:
          return NetworkException(message: 'İstek zaman aşımına uğradı');
        case DioExceptionType.receiveTimeout:
          return NetworkException(message: 'Yanıt zaman aşımına uğradı');
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case 400:
              return BadRequestException(message: 'Geçersiz istek');
            case 401:
              return UnauthorizedException(message: 'Yetkisiz erişim');
            case 404:
              return NotFoundException(message: 'Bulunamadı');
            default:
              return ServerException(message: 'Sunucu hatası');
          }
        case DioExceptionType.cancel:
          return RequestCancelledException(message: 'İstek iptal edildi');
        default:
          return UnknownException(message: 'Bilinmeyen bir hata oluştu');
      }
    }
    return UnknownException(message: 'Bilinmeyen bir hata oluştu');
  }
}
