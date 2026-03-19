import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_icon_state.dart';
import 'package:bookia/feature/wishlist/data/repository/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  WishlistActionCubit() : super(WishlistActionsInitial());

  Future<void> addToWishlist(int productId) async {
    emit(WishlistActionsState());
    var data = await WishlistRepo.addToWishlist(productId);
    if (data != null) {
      var products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistActionsSuccessState(msg: 'Added To Wishlist'));
    } else {
      emit(WishlistActionsErrorState());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistActionsState());
    var data = await WishlistRepo.removeFromWishlist(productId);
    if (data != null) {
      var products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistActionsSuccessState(msg: 'Removed From Wishlist'));
    } else {
      emit(WishlistActionsErrorState());
    }
  }

  bool isProductInWishlist(int productId) {
    var wishlistIds = SharedPref.getWishlistIds();
    return wishlistIds.contains(productId);
  }
}
