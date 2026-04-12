import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/base_response.dart';
import 'package:bookia/core/services/dio/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DioProvider {
  static late final Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: Apis.baseUrl));
  }

  static Future<Either<Failure, dynamic>> postApi({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool unwrapData = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return _handleResponse(response, unwrapData);
      } else {
        return Left(
          ApiFailure(
            message: response.data["message"] ?? "Somthing Went Wrong",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (_) {
      return Left(UnknownFailure(message: "SomeThing Went Wrong"));
    }
  }

  static Either<Failure, dynamic> _handleResponse(
    Response<dynamic> response,
    bool unwrapData,
  ) {
    if (!unwrapData) return Right(response.data);
    final body = response.data;
    if (body is! Map<String, dynamic>) return Right(body);
    if (body.containsKey("data")) {
      try {
        var baseResponse = BaseResponse.fromJson(body);
        return Right(baseResponse.data);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    } else {
      return Right(body);
    }
  }

  static Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkFailure(message: "No Internet Connection");
      case DioExceptionType.badCertificate:
        return Failure(message: "Bad Certificate");
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        final msg = (data is Map<String, dynamic>) ? data["message"] : null;
        return ApiFailure(message: msg?.toString() ?? "Bad Response");
      case DioExceptionType.cancel:
        return ApiFailure(message: "Request Cancelled");
      case DioExceptionType.unknown:
        return UnknownFailure(message: "Unknown Error");
    }
  }

  static Future<Either<Failure, dynamic>> getApi({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool unwrapData = true,
  }) async {
    try {
      var response = await dio.get(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return _handleResponse(response, unwrapData);
      } else {
        return Left(
          ApiFailure(
            message: response.data["message"] ?? "Somthing Went Wrong",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (_) {
      return Left(UnknownFailure(message: "SomeThing Went Wrong"));
    }
  }

  static Future<Either<Failure, dynamic>> putApi({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool unwrapData = true,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return _handleResponse(response, unwrapData);
      } else {
        return Left(
          ApiFailure(
            message: response.data["message"] ?? "Somthing Went Wrong",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (_) {
      return Left(UnknownFailure(message: "SomeThing Went Wrong"));
    }
  }

  static Future<Either<Failure, dynamic>> deleteApi({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool unwrapData = true,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return _handleResponse(response, unwrapData);
      } else {
        return Left(
          ApiFailure(
            message: response.data["message"] ?? "Somthing Went Wrong",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (_) {
      return Left(UnknownFailure(message: "SomeThing Went Wrong"));
    }
  }

  static Future<Either<Failure, dynamic>> patchApi({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool unwrapData = true,
  }) async {
    try {
      var response = await dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return _handleResponse(response, unwrapData);
      } else {
        return Left(
          ApiFailure(
            message: response.data["message"] ?? "Somthing Went Wrong",
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception catch (_) {
      return Left(UnknownFailure(message: "SomeThing Went Wrong"));
    }
  }
}
