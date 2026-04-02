import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wish_list/data/models/wish_list_response/wish_list_response.dart';

class WishListRepo {
  static Future<WishListResponse?> getWishList() async {
    try {
      var response = await DioProvider.get(
        endPoint: Apis.wishlist,
        queryParameters: {"page": 1},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return WishListResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> addToWishList(int productID) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.addToWishlist,
        queryParameters: {"page": 1},
        data: {"product_id": productID},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return WishListResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<WishListResponse?> removeFromWishList(int productId) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.removeFromWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        queryParameters: {"page": 1},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return WishListResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
