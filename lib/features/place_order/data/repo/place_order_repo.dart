import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';

class PlaceOrderRepo {
  static Future<List<GovernorateModel>> getGovernorates() async {
    try {
      final response = await DioProvider.get(
        endPoint: Apis.governorates,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List data = response.data["data"] ?? [];
        return data.map((e) => GovernorateModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<int?> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    try {
      final response = await DioProvider.post(
        endPoint: Apis.placeOrder,
        data: {
          "governorate_id": governorateId,
          "name": name,
          "phone": phone,
          "address": address,
          "email": email,
        },
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final orderId = response.data["data"]?["id"];
        if (orderId is int) return orderId;
        return int.tryParse(orderId?.toString() ?? '');
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
