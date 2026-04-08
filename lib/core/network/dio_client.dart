import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:bookia/core/network/api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = SharedPref.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) {
    return dio.get(endpoint, queryParameters: queryParams);
  }

  Future<Response> post(String endpoint, {dynamic data}) {
    return dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, {dynamic data}) {
    return dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) {
    return dio.delete(endpoint);
  }
}