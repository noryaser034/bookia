// Base UseCase contract.
// Every use case must implement this interface.
//
// [Output] — the successful return type
// [Params] — the input parameters type (use [NoParams] when there are none)
import 'package:bookia/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

// Use this when a use case needs no parameters.
class NoParams {}
