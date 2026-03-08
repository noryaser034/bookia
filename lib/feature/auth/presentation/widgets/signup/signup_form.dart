import 'package:bookia/core/functions/validation.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/password_text_form_filed.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<AuthCubit>();

    return Column(
      children: [

        CustomTextFormField(
          controller: cubit.usernameController,
          hintText: "Username",
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your name";
            }
            return null;
          },
        ),

        const SizedBox(height: 11),

        CustomTextFormField(
          controller: cubit.emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {

            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }

            if (!isEmailValid(value)) {
              return "Please enter a valid email";
            }

            return null;
          },
        ),

        const SizedBox(height: 11),

        PasswordTextFormFiled(
          controller: cubit.passwordController,
          hintText: "Password",
          validator: (value) {

            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }

            if (value.length < 8) {
              return "Password must be at least 8 characters";
            }

            return null;
          },
        ),

        const SizedBox(height: 11),

        PasswordTextFormFiled(
          controller: cubit.confirmPasswordController,
          hintText: "Confirm Password",
          validator: (value) {

            if (value != cubit.passwordController.text) {
              return "Passwords do not match";
            }

            return null;
          },
        ),

      ],
    );
  }
}