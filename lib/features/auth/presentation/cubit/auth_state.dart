part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class ForgetPasswordLoading extends AuthState {}

class VerifyOtpLoading extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class RegisterSuccess extends AuthState {}

class VerifyOtpSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class AuthPasswordResetSent extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}