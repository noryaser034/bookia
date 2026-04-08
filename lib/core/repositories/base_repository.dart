import 'package:bookia/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> handleError<T>(Future<T> Function() action);
}
