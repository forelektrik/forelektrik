// lib/core/errors/exceptions.dart

class NetworkException implements Exception {
  final String message;
  NetworkException({required this.message});

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});

  @override
  String toString() => message;
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException({required this.message});

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({required this.message});

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});

  @override
  String toString() => message;
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException({required this.message});

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});

  @override
  String toString() => message;
}
