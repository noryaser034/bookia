import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/sherd_pref.dart';
import 'package:bookia/core/styles/main_app.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();

  runApp(
    BlocProvider(
      create: (context) => HomeCubit()..initLoadData(),
      child: const MainApp(),
    ),
  );
}
