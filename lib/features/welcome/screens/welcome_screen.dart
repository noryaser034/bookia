import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const Spacer(flex: 1),
                SvgPicture.asset(AppImages.logoSvg),
                const Gap(30),
                Text(context.translate("order_now"), style: TextStyles.w400s20),
                const Spacer(flex: 4),
                MainButton(
                  text: context.translate("login"),
                  onPressed: () {
                    pushTo(Routes.login, context);
                  },
                ),
                const Gap(15),
                MainButton(
                  text: context.translate("register"),
                  onPressed: () {
                    pushTo(Routes.register, context);
                  },
                  color: AppColors.bgColor,
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
