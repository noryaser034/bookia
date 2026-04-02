import 'package:bookia/core/services/api/api.dart';
import 'package:dio/dio.dart';

abstract class DioProvider {
  static late final Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: Apis.baseUrl));
  }

  static Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response> patch({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.patch(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
