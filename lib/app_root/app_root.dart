import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/cubits/app_cubit/app_cubit.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Bookia extends StatelessWidget {
  const Bookia({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: Locale(context.read<AppCubit>().languageCode),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: Routes.routs,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: AppFonts.dmSerifDisplay,
              scaffoldBackgroundColor: AppColors.bgColor,
              appBarTheme:
                  const AppBarThemeData(backgroundColor: AppColors.bgColor),
              dividerColor: AppColors.borderColor,
            ),
          );
        },
      ),
    );
  }
}
