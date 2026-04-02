import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:bookia/features/auth/presentation/screens/forget_password.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/book_details/presentation/screens/book_details_screen.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/presentation/screens/home_screen.dart';
import 'package:bookia/features/home/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/home/search/presentation/screens/search_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/orders/my_orders/presentation/cubit/my_order_cubit.dart';
import 'package:bookia/features/orders/my_orders/presentation/screens/my_orders_screen.dart';
import 'package:bookia/features/orders/order_details/presentation/cubit/order_details_cubit.dart';
import 'package:bookia/features/orders/order_details/presentation/screens/order_details_screen.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/place_order/presentation/screens/congrats_screen.dart';
import 'package:bookia/features/place_order/presentation/screens/place_order_screen.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:bookia/features/profile_folder/profile/presentation/screens/profile_screen.dart';
import 'package:bookia/features/profile_folder/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:bookia/features/profile_folder/reset_password/presentation/screens/reset_password_screen.dart';
import 'package:bookia/features/welcome/screens/splash_screen.dart';
import 'package:bookia/features/welcome/screens/welcome_screen.dart';
import 'package:bookia/features/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String mainApp = "/mainApp";
  static const String home = "/home";
  static const String forgetPassword = "/forget-password";
  static const String passwordChanged = "/password-changed";
  static const String otpScreen = "/otpScreen";
  static const String createNewPassword = "/create-new-password";
  static const String bookDetails = "/book-details";
  static const String wishList = "/wish-list";
  static const String placeOrder = "/place-order";
  static const String congrats = "/congrats";
  static const String profile = "/profile";
  static const String editProfile = "/edit-profile";
  static const String resetPassword = "/reset-password";
  static const String myOrders = "/my-orders";
  static const String search = "/search";
  static const String orderDetails = "/order-details";

  static var routs = GoRouter(
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.mainApp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final initialIndex = extra?['index'] as int? ?? 0;
          final refreshId = extra?['refreshId'] as int? ?? 0;

          return MainAppScreen(
            key: ValueKey(refreshId),
            initialIndex: initialIndex,
          );
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: Routes.otpScreen,
        builder: (context, state) {
          final cubit = state.extra as AuthCubit;
          return BlocProvider.value(
            value: cubit,
            child: const OtpVerificationScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.createNewPassword,
        builder: (context, state) {
          final cubit = state.extra as AuthCubit;
          return BlocProvider.value(
            value: cubit,
            child: const CreateNewPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.passwordChanged,
        builder: (context, state) {
          final cubit = state.extra as AuthCubit;
          return BlocProvider.value(
            value: cubit,
            child: const PasswordChangedScreen(),
          );
        },
      ),

      GoRoute(
        path: Routes.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),

      GoRoute(
        path: Routes.bookDetails,
        builder: (context, state) => BlocProvider(
          create: (context) => BookDetailsCubit(),
          child: BookDetailsScreen(product: state.extra as Product),
        ),
      ),

      GoRoute(
        path: Routes.wishList,
        builder: (context, state) => const WishlistScreen(),
      ),

      GoRoute(
        path: Routes.placeOrder,
        builder: (context, state) {
          final checkoutData = state.extra as CheckoutData;

          return BlocProvider(
            create: (context) => PlaceOrderCubit()..getGovernorates(),
            child: PlaceOrderScreen(checkoutData: checkoutData),
          );
        },
      ),
      GoRoute(
        path: Routes.congrats,
        builder: (context, state) => const CongratsScreen(),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => EditProfileCubit()..loadInitialData(),
          child: const EditProfileScreen(),
        ),
      ),

      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => ResetPasswordCubit(),
          child: const ResetPasswordScreen(),
        ),
      ),

      GoRoute(
        path: Routes.myOrders,
        builder: (context, state) => BlocProvider(
          create: (context) => MyOrderCubit(),
          child: const MyOrdersScreen(),
        ),
      ),

      GoRoute(
        path: Routes.search,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit(),
          child: const SearchScreen(),
        ),
      ),

     GoRoute(
  path: Routes.orderDetails,
  builder: (context, state) {
    final orderId = state.extra as int;

    return BlocProvider(
      create: (context) => OrderDetailsCubit()..getOrderDetails(orderId),
      child: OrderDetailsScreen(orderId: orderId),
    );
  },
),
    ],
  );
}
