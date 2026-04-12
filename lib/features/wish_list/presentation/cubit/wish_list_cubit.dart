import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/wish_list/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:bookia/features/wish_list/domain/usecases/get_wishlist_usecase.dart';
import 'package:bookia/features/wish_list/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:bookia/features/wish_list/presentation/cubit/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishListCubit({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
  }) : super(WishListInitialState());

  List<Product> products = [];

  void getWishList() async {
    emit(WishListLoadingState());
    var response = await getWishlistUseCase.call(NoParams());
    response.fold((l) => emit(WishListErrorState()), (data) {
      products = data.data?.product ?? [];
      SharedPref.cashWishListIds(products);
      emit(WishListSuccessState());
    });
  }

  void removeFromWishList(int productId) async {
    emit(WishListLoadingState());
    var response = await removeFromWishlistUseCase.call(productId);
    response.fold((l) => emit(WishListErrorState()), (data) {
      products = data.data?.product ?? [];
      SharedPref.cashWishListIds(products);
      emit(WishListSuccessState());
    });
  }
}
