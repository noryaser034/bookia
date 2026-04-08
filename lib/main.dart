import 'package:bookia/core/app_root/app_root.dart';
import 'package:bookia/core/network/dio_client.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  DioClient();
  runApp(const Bookia());
}
