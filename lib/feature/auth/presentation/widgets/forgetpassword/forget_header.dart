import 'package:bookia/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 40),
        Text("Forgot Password?", style: TextStyles.header),
        const SizedBox(height: 10),
        Text(
          "Don't worry! It happens. Please enter the address associated with your account.",
          style: TextStyles.caption1.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}