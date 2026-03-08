import 'package:bookia/feature/auth/data/model/registerparams.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /// LOGIN
  Future<void> login() async {

    if (!formKey.currentState!.validate()) return;

    emit(AuthLoadingState());

    final response = await AuthRepo.login(
      Registerparams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error: "Login Failed"));
    }
  }

  /// REGISTER
  Future<void> register() async {

    if (!formKey.currentState!.validate()) return;

    emit(AuthLoadingState());

    final response = await AuthRepo.register(
      Registerparams(
        name: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        passwordConfirmation: confirmPasswordController.text.trim(),
      ),
    );

    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error: "Register Failed"));
    }
  }

/// FORGOT PASSWORD
  Future<void> forgotPassword() async {

    if (!formKey.currentState!.validate()) return;

    emit(AuthLoadingState());

    final response = await AuthRepo.forgotPassword(
      Registerparams(
        email: emailController.text.trim(),
      ),
    );

    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error: "Forgot Password Failed"));
    }
  }



}