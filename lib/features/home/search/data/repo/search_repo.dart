import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';

class SearchRepo {
  static Future<List<Product>?> getAllProducts() async {
    try {
      var response = await DioProvider.get(endPoint: Apis.allProducts);

      if (response.statusCode == 200) {
        final List productsJson = response.data["data"]["products"];
        return productsJson.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<Product>?> searchProducts({required String name}) async {
    try {
      var response = await DioProvider.get(
        endPoint: Apis.productsSearch,
        queryParameters: {"name": name},
      );

      if (response.statusCode == 200) {
        final List productsJson = response.data["data"]["products"];
        return productsJson.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
