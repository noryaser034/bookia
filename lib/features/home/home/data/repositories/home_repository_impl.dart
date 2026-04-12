import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/home/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';
import 'package:bookia/features/home/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SliderModel>>> getSliders() async {
    final response = await remoteDataSource.getSliders();
    return response.fold((failure) => Left(failure), (data) {
      try {
        final List slidersJson = data["sliders"] ?? [];
        final sliders = slidersJson
            .map((e) => SliderModel.fromJson(e))
            .toList();
        return Right(sliders);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, List<Product>>> getBestSellerProducts() async {
    final response = await remoteDataSource.getBestSellerProducts();
    return response.fold((failure) => Left(failure), (data) {
      try {
        final List productsJson = data["products"] ?? [];
        final products = productsJson.map((e) => Product.fromJson(e)).toList();
        return Right(products);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
