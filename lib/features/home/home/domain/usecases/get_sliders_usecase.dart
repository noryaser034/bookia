import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';
import 'package:bookia/features/home/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetSlidersUseCase implements UseCase<List<SliderModel>, NoParams> {
  final HomeRepository repository;

  GetSlidersUseCase(this.repository);

  @override
  Future<Either<Failure, List<SliderModel>>> call(NoParams params) {
    return repository.getSliders();
  }
}
