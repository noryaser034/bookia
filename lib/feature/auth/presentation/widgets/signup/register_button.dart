import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/feature/auth/presentation/screens/forgetpassword.dart';
import 'package:bookia/feature/auth/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        /// loading
        if (state is AuthLoadingState) {
          ShowLoadingDialog(context);
        }
        /// success
        else if (state is AuthSuccessState) {
          pop(context); 
          pushTo(context, const ForgetPassword());
        }
        /// error
        else if (state is AuthErrorState) {
          pop(context);
          showErrorDialog(context, state.error);
        }
      },

      builder: (context, state) {
        var cubit = context.read<AuthCubit>();

        return MainButton(
          text: "Register",
          onpress: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.register();
            }
          },
          backgroundcolor: AppColors.primary,
          bordercolor: AppColors.primary,
        );
      },
    );
  }
}
