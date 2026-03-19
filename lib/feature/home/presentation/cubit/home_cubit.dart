import 'package:bookia/feature/home/data/models/best_seller_books_response/best_seller_books_response.dart';
import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/feature/home/data/repository/hemo_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Slider> sliders = [];
  List<Product> products = [];

  int yourActiveIndex = 0;

  Future<void> initLoadData() async {
    emit(HomeLoadingState());

    // run apis in parallel (1 sec)
    var responses = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.getBestSellers(),
    ]);

    // check responses
    var slidersResponse = responses[0] as SliderResponse?;
    var bestSellerResponse = responses[1] as BestSellerBooksResponse?;

    if (slidersResponse != null || bestSellerResponse != null) {
      sliders = slidersResponse?.data?.sliders ?? [];
      products = bestSellerResponse?.data?.products ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }

  void onChangeSlider(int index) {
    yourActiveIndex = index;
    emit(HomeSuccessState());
  }
}
