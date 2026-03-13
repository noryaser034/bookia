import 'package:bookia/feature/auth/presentation/screens/login_screen.dart';
import 'package:bookia/feature/auth/presentation/screens/signup_screen.dart';
import 'package:bookia/feature/auth/presentation/screens/forgetpassword.dart';
import 'package:bookia/feature/auth/presentation/screens/otp.dart';
import 'package:bookia/feature/auth/presentation/screens/Create.dart';
import 'package:bookia/feature/auth/presentation/screens/password_changed.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/splach/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

var globalContext = GlobalKey<NavigatorState>();

class Routes {
  static String splash = '/';
  static String login = '/login';
  static String register = '/register';
  static String welcome = '/welcome';
  static String main = '/main';
  static String forgetPassword = '/forget-password';
  static String otp = '/otp';
  static String createPassword = '/create-password';
  static String passwordChanged = '/password-changed';

  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: welcome, builder: (context, state) => const Welcome()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: register, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: main, builder: (context, state) => const MainAppScreen()),
      GoRoute(path: forgetPassword, builder: (context, state) => const ForgetPassword()),
      GoRoute(path: otp, builder: (context, state) => const OtpVerificationScreen()),
      GoRoute(path: createPassword, builder: (context, state) => const Create()),
      GoRoute(path: passwordChanged, builder: (context, state) => const PasswordChangedScreen()),
    ],
  );
}