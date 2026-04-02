import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    String? token = SharedPref.getToken();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (token != null && token.isNotEmpty) {
        pushReplacment(Routes.mainApp, context);
      } else {
        pushReplacment(Routes.login, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset(AppImages.logoSvg)],
          ),
          const Gap(10),
          Text(context.translate("order_now"), style: TextStyles.w400s18),
        ],
      ),
    );
  }
}
