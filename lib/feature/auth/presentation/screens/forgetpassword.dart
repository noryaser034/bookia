import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/widgets/forgetpassword/forget_header.dart';
import 'package:bookia/feature/auth/presentation/widgets/forgetpassword/forget_secssion.dart';
import 'package:bookia/feature/auth/presentation/widgets/forgetpassword/forgetbutton.dart';
import 'package:bookia/feature/auth/presentation/widgets/forgetpassword/forgetform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: const _LoginView());
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 30),
                        ForgetHeader(),
                        SizedBox(height: 30),
                        ForgetForm(),
                        SizedBox(height: 30),
                        ForgetButton(),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ForgetSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
