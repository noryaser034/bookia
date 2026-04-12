/// Canonical failure classes used across domain and data layers.
/// Import this file from `package:bookia/core/error/failure.dart`.
class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});
}

class ApiFailure extends Failure {
  ApiFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class ParseFailure extends Failure {
  ParseFailure({required super.message});
}
