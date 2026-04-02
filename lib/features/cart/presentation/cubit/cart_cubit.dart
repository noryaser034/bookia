import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  Data? cartData;
  CheckoutData? checkoutData;
  List<CartItem?> get cartItems => cartData?.cartItems ?? [];

  double get totalPrice => double.tryParse(cartData?.total ?? '0') ?? 0.0;

  Future<void> getCartItems() async {
    emit(CartLoadingState());

    final data = await CartRepo.getCartItems();

    if (data != null) {
      cartData = data;
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  Future<void> removeFromCart(int itemId) async {
    final isRemoved = await CartRepo.removeFromCart(itemId);

    if (isRemoved) {
      cartData?.cartItems?.removeWhere((item) => item.itemId == itemId);
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
      await getCartItems();
    } else {
      emit(CartErrorState());
    }
  }

  Future<void> updateCartQuantity({
    required int itemId,
    required int quantity,
  }) async {
    if (quantity < 1) return;

    final itemIndex = cartItems.indexWhere((item) => item?.itemId == itemId);

    if (itemIndex == -1) return;

    final currentItem = cartItems[itemIndex];
    final stock = currentItem?.itemProductStock ?? 0;

    if (quantity > stock) return;

    emit(CartLoadingState());

    final data = await CartRepo.updateCartQuantity(
      cartItemId: itemId,
      quantity: quantity,
    );

    if (data != null) {
      cartData = data;
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  Future<bool> checkout() async {
    emit(CheckoutLoadingState());
    checkoutData = null;

    final data = await CartRepo.checkout();

    if (data != null) {
      checkoutData = data;
      SharedPref.cashCartListIds(cartItems);
      emit(CheckoutSuccessState());
      return true;
    } else {
      emit(CheckoutErrorState());
      return false;
    }
  }
}
