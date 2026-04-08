import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bookia/features/auth/domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
  }) : super(AuthInitial());

  User? user;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? resetEmail;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    final result = await loginUseCase(
      LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (loggedUser) {
        user = loggedUser;
        emit(LoginSuccess());
      },
    );
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (registeredUser) {
        user = registeredUser;
        emit(RegisterSuccess());
      },
    );
  }

  Future<void> forgetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emit(AuthFailure('Email is required'));
      return;
    }

    emit(ForgetPasswordLoading());

    final result = await forgetPasswordUseCase(email);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) {
        resetEmail = email;
        emit(AuthPasswordResetSent());
      },
    );
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.length != 6) {
      emit(AuthFailure('OTP must be 6 digits'));
      return;
    }

    emit(VerifyOtpLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(VerifyOtpSuccess());
  }

  Future<void> resetPassword() async {
    final email = resetEmail ?? '';
    final password = passwordController.text.trim();
    final confirm = confirmController.text.trim();

    if (email.isEmpty) {
      emit(AuthFailure('No email set'));
      return;
    }

    if (password.length < 6) {
      emit(AuthFailure('Password must be at least 6 characters'));
      return;
    }

    if (password != confirm) {
      emit(AuthFailure('Passwords do not match'));
      return;
    }

    emit(ResetPasswordLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(ResetPasswordSuccess());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    nameController.dispose();
    phoneController.dispose();
    otpController.dispose();
    return super.close();
  }
}