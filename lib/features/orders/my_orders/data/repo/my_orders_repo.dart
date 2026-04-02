import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';

class MyOrdersRepo {
  static Future<MyOrdersResponse?> getOrders() async {
    try {
      final token = SharedPref.getToken();
      var response = await DioProvider.get(
        endPoint: Apis.myOrders,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return MyOrdersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
