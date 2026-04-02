import 'dart:developer';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/wish_list/data/repo/wish_list_repo.dart';
import 'package:bookia/features/wish_list/presentation/cubit/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitialState());

  List<Product> products = [];

  void getWishList() async {
    emit(WishListLoadingState());
    var data = await WishListRepo.getWishList();
    if (data != null) {
      products = data.data?.product ?? [];
      SharedPref.cashWishListIds(products);
      log(products.length.toString());
      emit(WishListSuccessState());
    } else {
      emit(WishListErrorState());
    }
  }

  void removeFromWishList(int productId) async {
    emit(WishListLoadingState());
    var data = await WishListRepo.removeFromWishList(productId);
    if (data != null) {
      products = data.data?.product ?? [];
      SharedPref.cashWishListIds(products);
      emit(WishListSuccessState());
    } else {
      emit(WishListErrorState());
    }
  }
}
