import 'dart:developer';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/services/local/sherd_pref.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/core/widgets/custom_svg.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/welcome/welcome.dart';
import 'package:flutter/material.dart';
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
    log(token.toString());
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        // ignore: use_build_context_synchronously
        pushReplacement(context, MainAppScreen());
      } else {
        // ignore: use_build_context_synchronously
        pushReplacement(context, Welcome());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvg(path: AppImages.logosvg, width: 250),
            Gap(10),
            Text('Order Your Book Now!', style: TextStyles.subtitle),
          ],
        ),
      ),
    );
  }
}
