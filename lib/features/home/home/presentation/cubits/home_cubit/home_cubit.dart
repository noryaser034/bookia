import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';
import 'package:bookia/features/home/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInialState());

  List<SliderModel> sliders = [];
  List<Product> products = [];

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final response = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSellerProducts(),
      ]);

      sliders = response[0] as List<SliderModel>;
      products = response[1] as List<Product>;

      if (sliders.isEmpty && products.isEmpty) {
        emit(HomeErrorState(errorMsg: "failed_to_load_data"));
        return;
      }

      emit(HomeSuccessState(products: products, sliders: sliders));
    } catch (e) {
      emit(HomeErrorState(errorMsg: "failed_to_load_data"));
    }
  }
}
