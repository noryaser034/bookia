import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:bookia/feature/home/data/models/best_seller_book_response/best_seller_book_response.dart';
import 'package:bookia/feature/home/data/models/best_seller_book_response/poduct.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/feature/home/data/models/slider_response/slider.dart'
    as slider_model;
import 'package:bookia/feature/home/data/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<slider_model.Slider> sliders = [];
  List<Product> products = [];
  int yourActiveIndex = 0;

  Future<void> initLoadData() async {
    emit(HomeLoadingState());

    try {
      
      final responses = await Future.wait([
        HomeRepo.getSliders(),
        HomeRepo.getBestSellers(),
      ]);

      final slidersResponse = responses[0] as SliderResponse?;
      final bestSellerResponse = responses[1] as BestSellerBooksResponse?;

      if (bestSellerResponse != null && bestSellerResponse.data != null) {
        sliders = slidersResponse?.data?.sliders ?? [];
        products = bestSellerResponse.data?.products ?? [];

        emit(HomeSuccessState());
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  
  void onChangeSlider(int index) {
    yourActiveIndex = index;
    emit(HomeSuccessState());
  }
}
