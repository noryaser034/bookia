import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bookia/core/routes/routes.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.successSvg),
              const SizedBox(height: 20),
              Text(
                "SUCCESS!",
                style: TextStyles.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Your order will be delivered soon. Thank you for choosing our app!",
                style: TextStyles.caption1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MainButton(
                text: "Back To Home",
                onPressed: () {
                  context.go(Routes.main);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
