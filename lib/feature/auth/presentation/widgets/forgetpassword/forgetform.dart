import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetForm extends StatelessWidget {
  const ForgetForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      children: [
        CustomTextFormField(
          controller: cubit.emailController,
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
