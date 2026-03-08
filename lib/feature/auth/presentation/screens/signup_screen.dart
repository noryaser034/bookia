import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/widgets/signup/signup_form.dart';
import 'package:bookia/feature/auth/presentation/widgets/signup/signup_header.dart';
import 'package:bookia/feature/auth/presentation/widgets/signup/register_button.dart';
import 'package:bookia/feature/auth/presentation/widgets/login/login_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: const _SignUpView());
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 40),
                        SignUpHeader(),
                        SizedBox(height: 20),
                        SignUpForm(),
                        SizedBox(height: 30),
                        RegisterButton(),
                      ],
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: LoginSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
