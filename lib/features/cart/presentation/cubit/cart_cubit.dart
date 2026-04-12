import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:bookia/features/cart/domain/usecases/checkout_usecase.dart';
import 'package:bookia/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:bookia/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:bookia/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final CheckoutUseCase checkoutUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartUseCase,
    required this.checkoutUseCase,
  }) : super(CartInitialState());

  Data? cartData;
  CheckoutData? checkoutData;
  List<CartItem?> get cartItems => cartData?.cartItems ?? [];

  double get totalPrice => double.tryParse(cartData?.total ?? '0') ?? 0.0;

  Future<void> getCartItems() async {
    emit(CartLoadingState());

    final response = await getCartUseCase.call(NoParams());

    response.fold((l) => emit(CartErrorState()), (data) {
      cartData = data;
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
    });
  }

  Future<void> removeFromCart(int itemId) async {
    final response = await removeFromCartUseCase.call(itemId);

    response.fold((l) => emit(CartErrorState()), (_) async {
      cartData?.cartItems?.removeWhere((item) => item.itemId == itemId);
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
      await getCartItems();
    });
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

    final response = await updateCartUseCase.call(
      UpdateCartParams(cartItemId: itemId, quantity: quantity),
    );

    response.fold((l) => emit(CartErrorState()), (data) {
      cartData = data;
      SharedPref.cashCartListIds(cartItems);
      emit(CartSuccessState());
    });
  }

  Future<bool> checkout() async {
    emit(CheckoutLoadingState());
    checkoutData = null;

    final response = await checkoutUseCase.call(NoParams());

    return response.fold(
      (l) {
        emit(CheckoutErrorState());
        return false;
      },
      (data) {
        checkoutData = data;
        SharedPref.cashCartListIds(cartItems);
        emit(CheckoutSuccessState());
        return true;
      },
    );
  }
}
