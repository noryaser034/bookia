import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:bookia/features/place_order/domain/repositories/place_order_repository.dart';
import 'package:dartz/dartz.dart';

class GetGovernoratesUseCase
    implements UseCase<List<GovernorateModel>, NoParams> {
  final PlaceOrderRepository repository;

  GetGovernoratesUseCase(this.repository);

  @override
  Future<Either<Failure, List<GovernorateModel>>> call(NoParams params) {
    return repository.getGovernorates();
  }
}
