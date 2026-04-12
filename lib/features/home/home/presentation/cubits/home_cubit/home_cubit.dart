import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';
import 'package:bookia/features/home/home/domain/usecases/get_best_sellers_usecase.dart';
import 'package:bookia/features/home/home/domain/usecases/get_sliders_usecase.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSlidersUseCase getSlidersUseCase;
  final GetBestSellersUseCase getBestSellersUseCase;

  HomeCubit({
    required this.getSlidersUseCase,
    required this.getBestSellersUseCase,
  }) : super(HomeInialState());

  List<SliderModel> sliders = [];
  List<Product> products = [];

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    final slidersResult = await getSlidersUseCase.call(NoParams());
    final productsResult = await getBestSellersUseCase.call(NoParams());

    slidersResult.fold((l) {}, (r) => sliders = r);
    productsResult.fold((l) {}, (r) => products = r);

    if (sliders.isEmpty && products.isEmpty) {
      emit(HomeErrorState(errorMsg: "failed_to_load_data"));
      return;
    }

    emit(HomeSuccessState(products: products, sliders: sliders));
  }
}
