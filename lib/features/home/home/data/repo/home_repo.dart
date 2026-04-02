import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/data/models/slider_model.dart';

class HomeRepo {
  static Future<List<SliderModel>?> getSliders() async {
    try {
      var response = await DioProvider.get(endPoint: Apis.sliders);

      if (response.statusCode == 200) {
        final List slidersJson = response.data["data"]["sliders"];
        return slidersJson.map((e) => SliderModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } on Exception catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<Product>?> getBestSellerProducts() async {
    try {
      var response = await DioProvider.get(endPoint: Apis.productsBestSeller);

      if (response.statusCode == 200) {
        final List bestSellerJson = response.data["data"]["products"];
        return bestSellerJson.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
