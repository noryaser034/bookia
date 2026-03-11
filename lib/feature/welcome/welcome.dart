import 'package:bookia/feature/auth/presentation/screens/login_screen.dart';
import 'package:bookia/feature/auth/presentation/screens/signup_screen.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/core/widgets/custom_svg.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 22,
            right: 22,
            child: Column(
              children: [
                Spacer(flex: 2),
                CustomSvg(path: AppImages.logosvg),
                Gap(15),
                Text("Order Your Book Now!", style: TextStyles.subtitle),
                Spacer(flex: 4),
                MainButton(
                  text: "Login",
                  onpress: () {
                    pushReplacement(context, LoginScreen());
                  },
                  backgroundcolor: AppColors.primary,
                  bordercolor: AppColors.primary,
                  textStyle: TextStyles.body.copyWith(
                    color: Colors.white,
                  ),
                ),
                Gap(15),
                MainButton(
                  text: "Register",
                  onpress: () {
                    pushReplacement(context, SignUpScreen());
                  },
                  backgroundcolor: AppColors.background,
                  bordercolor: AppColors.darkcolor,
                  textStyle: TextStyles.body.copyWith(
                    color: AppColors.darkcolor,
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
