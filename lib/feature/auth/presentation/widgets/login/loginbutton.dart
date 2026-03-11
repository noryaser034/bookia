import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/feature/auth/presentation/widgets/dialog.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushToBase(context, MainAppScreen());
        } else if (state is AuthErrorState) {
          pop(context);
          pushToBase(context, MainAppScreen());

          showErrorDialog(context, state.error);
        } else if (state is AuthLoadingState) {
          ShowLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();

        return MainButton(
          text: "Login",
          onpress: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.login();
            }
          },
          backgroundcolor: AppColors.primary,
          bordercolor: AppColors.primary,
        );
      },
    );
  }
}
