import 'package:flutter/material.dart';

var globalContext = GlobalKey<NavigatorState>();

class Routes {
  static String splash = '/';
  static String login = '/login';
  static String register = '/register';
  static String welcome = '/welcome';
  static String main = '/main';
  static String details = '/details';
  static String placeOrder = '/place-order';
  static String orderSuccess = '/order-success';
}