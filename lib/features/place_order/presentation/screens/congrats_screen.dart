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

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.successSvg),
            const Gap(50),
            Text(context.translate("congrats").toUpperCase(),
                style: TextStyles.w400s36),
            const Gap(22),
            Text(
              context.translate("order_success_subtitle"),
              textAlign: TextAlign.center,
              style: TextStyles.w400s18.copyWith(
                color: AppColors.black3,
                fontFamily: "Nunito Sans",
              ),
            ),
            const Gap(51),
            MainButton(
              text: context.translate("back_to_home"),
              onPressed: () {
                pushAndClearStack(
                  Routes.mainApp,
                  context,
                  extra: {
                    'index': 0,
                    'refreshId': DateTime.now().microsecondsSinceEpoch,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
