import 'package:bookia/core/services/dio/apis.dart';
import 'package:dio/dio.dart';

abstract class DioProvider {
  static late final Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apis.baseUrl,
      ),
    );
  }

  static Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(
      endpoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }
    static Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(
      endpoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }
    static Future<Response> put({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(
      endpoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }

    static Future<Response> deleted({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(
      endpoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }
  
    static Future<Response> patch({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.patch(
      endpoint,
      data: data,
      options: Options(headers: header),
      queryParameters: queryParameters,
    );
  }
}



