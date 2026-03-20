import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/register_screen.dart';
import 'package:bookia/feature/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:bookia/feature/contact_us/presentation/page/contact_us_screen.dart';
import 'package:bookia/feature/faq/presentation/cubit/faq_cubit.dart';
import 'package:bookia/feature/faq/presentation/page/faq_screen.dart';
import 'package:bookia/feature/place_order/presentation/page/place_order_screen.dart';
import 'package:bookia/feature/details/presentation/page/details_screen.dart';
import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/splash/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome_screen.dart';
import 'package:bookia/feature/place_order/presentation/page/congrats.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/change_password_screen.dart';
import 'package:bookia/feature/profile/presentation/page/my_orders_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppScreen(),
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) {
          return DetailsScreen(model: state.extra as Product);
        },
      ),
      GoRoute(
        path: Routes.placeOrder,
        builder: (context, state) {
          return PlaceOrderScreen(total: state.extra as String);
        },
      ),
      GoRoute(
        path: Routes.orderSuccess,
        builder: (context, state) => const OrderScreen(),
      ),
      GoRoute(
        path: Routes.myOrders,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit(),
          child: const MyOrdersScreen(),
        ),
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit()..getProfile(),
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit(),
          child: const ChangePasswordScreen(),
        ),
      ),
      GoRoute(
  path: Routes.faq,
  builder: (context, state) => BlocProvider(
    create: (context) => FaqCubit(),
    child: const FaqScreen(),
  ),
),
GoRoute(
  path: Routes.contactUs,
  builder: (context, state) => BlocProvider(
    create: (context) => ContactUsCubit(),
    child: const ContactUsScreen(),
  ),
),
    ],
  );
}