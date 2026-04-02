import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';

class HomeState {}

class HomeInialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<SliderModel> sliders;
  final List<Product> products;

  HomeSuccessState({required this.products, required this.sliders});
}

class HomeErrorState extends HomeState {
  final String errorMsg;

  HomeErrorState({required this.errorMsg});
}
