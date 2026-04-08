import 'package:bookia/core/network/dio_client.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(Map<String, dynamic> data);
  Future<AuthResponseModel> login(Map<String, dynamic> data);
  Future<void> forgetPassword(String email);
  Future<void> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthResponseModel> register(Map<String, dynamic> data) async {
    final response = await dioClient.post(ApiConstants.register, data: data);
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> login(Map<String, dynamic> data) async {
    final response = await dioClient.post(ApiConstants.login, data: data);
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> forgetPassword(String email) async {
    await dioClient.post(ApiConstants.forgetPassword, data: {'email': email});
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    await dioClient.post('verify-otp', data: {'email': email, 'otp': otp});
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await dioClient.post(ApiConstants.resetPassword, data: {
      'email': email,
      'password': newPassword,
      'password_confirmation': newPassword,
    });
  }

  @override
  Future<void> logout() async {
    await dioClient.post(ApiConstants.logout);
  }
}