// lib/core/network/interceptors/error_interceptor.dart

import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(message: 'Bağlantı zaman aşımına uğradı');
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(message: 'Geçersiz istek');
          case 401:
            throw UnauthorizedException(message: 'Yetkisiz erişim');
          case 403:
            throw ForbiddenException(message: 'Erişim reddedildi');
          case 404:
            throw NotFoundException(message: 'Bulunamadı');
          case 500:
            throw ServerException(message: 'Sunucu hatası');
          default:
            throw ServerException(message: 'Bir hata oluştu');
        }
      case DioExceptionType.cancel:
        throw RequestCancelledException(message: 'İstek iptal edildi');
      case DioExceptionType.unknown:
        if (err.error != null &&
            err.error.toString().contains('SocketException')) {
          throw NetworkException(message: 'İnternet bağlantısı yok');
        }
        throw UnknownException(message: 'Bilinmeyen bir hata oluştu');
      default:
        throw UnknownException(message: 'Bilinmeyen bir hata oluştu');
    }
  }
}
