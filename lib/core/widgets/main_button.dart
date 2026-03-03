import 'package:bookia/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onpress,
    required this.backgroundcolor,
    required this.bordercolor,
    this.textStyle = TextStyles.body,
  });
  final String text;
  final Function() onpress;
  final Color backgroundcolor;
  final Color bordercolor;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundcolor,
        minimumSize: Size(double.infinity, 70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: bordercolor, width: 2),
      ),
      onPressed: onpress,
      child: Text(text, style: textStyle),
    );
  }
}
