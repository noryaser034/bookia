import 'package:bookia/features/auth/data/models/forget_password_params.dart';
import 'package:bookia/features/auth/data/models/register_params.dart';
import 'package:bookia/features/auth/data/models/reset_password_params.dart';
import 'package:bookia/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final otpController = TextEditingController();

  Future<void> login() async {
    emit(AuthLoadingState());
    var response = await loginUseCase.call(
      RegisterParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.fold(
      (l) {
        emit(AuthErrorState(message: l.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    var response = await registerUseCase.call(
      RegisterParams(
        name: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmController.text,
      ),
    );
    response.fold(
      (l) {
        emit(AuthErrorState(message: l.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> forgetPassword() async {
    emit(AuthLoadingState());

    final params = ForgetPasswordParams(email: emailController.text);

    final response = await forgetPasswordUseCase.call(params);
    response.fold(
      (l) {
        emit(AuthErrorState(message: l.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> resetPassword() async {
    emit(AuthLoadingState());

    final params = ResetPasswordParams(
      verifyCode: otpController.text,
      newPassword: passwordController.text,
      confirmPassword: confirmController.text,
    );

    final response = await resetPasswordUseCase.call(params);
    response.fold(
      (l) => emit(AuthErrorState(message: l.message)),
      (r) => emit(AuthSuccessState()),
    );
  }
}
