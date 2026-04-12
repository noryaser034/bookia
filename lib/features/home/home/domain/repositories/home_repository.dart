import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<SliderModel>>> getSliders();
  Future<Either<Failure, List<Product>>> getBestSellerProducts();
}
