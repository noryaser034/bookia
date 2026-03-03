import 'package:flutter/material.dart';

void pushReplacement(BuildContext context, Widget newScreen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen)
      );
    }
    void pushTo(BuildContext context, Widget newScreen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen,
        )
      );
    }
    
      void popTo(BuildContext context, Widget newScreen) {
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen,
        )
      );
    }