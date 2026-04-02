import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacment(String route, BuildContext context, {Object? extra}) {
  GoRouter.of(context).pushReplacement(route, extra: extra);
}

Future<T?> pushTo<T>(String route, BuildContext context, {Object? extra}) {
  return GoRouter.of(context).push(route, extra: extra);
}

void pop(BuildContext context) {
  GoRouter.of(context).pop();
}

void pushAndClearStack(String route, BuildContext context, {Object? extra}) {
  GoRouter.of(context).go(route, extra: extra);
}
