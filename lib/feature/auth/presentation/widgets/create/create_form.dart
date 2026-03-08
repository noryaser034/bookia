import 'package:bookia/core/widgets/password_text_form_filed.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      children: [
        PasswordTextFormFiled(
          controller: cubit.passwordController,
          hintText: "New Password",
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
