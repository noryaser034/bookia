import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onpress,
    this.backgroundcolor,
    this.bordercolor,
    this.textStyle,
  });

  final String text;
  final VoidCallback onpress;
  final Color? backgroundcolor;
  final Color? bordercolor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundcolor ?? Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: bordercolor ?? Colors.transparent),
          ),
        ),
        onPressed: onpress,
        child: Text(
          text,
          style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}