import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';

// ignore: avoid_types_as_parameter_names
abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}