import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';

class CartRepo {
  static Future<Data?> getCartItems() async {
    try {
      var response = await DioProvider.get(
        endPoint: Apis.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Data.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Data?> addToCart(int productId) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.addToCart,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Data.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeFromCart(int cartItemId) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      return false;
    }
  }

  static Future<Data?> updateCartQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Data.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CheckoutData?> checkout() async {
    try {
      var response = await DioProvider.get(
        endPoint: Apis.checkout,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CheckoutData.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
