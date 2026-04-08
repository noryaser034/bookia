import 'package:dartz/dartz.dart';
import 'failure.dart';

extension FailureExtension<T> on Either<Failure, T> {
  T getOrElse(T defaultValue) => fold((_) => defaultValue, (r) => r);
}