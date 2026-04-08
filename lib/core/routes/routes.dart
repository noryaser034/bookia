import 'package:bookia/core/network/dio_client.dart';
import 'package:bookia/core/network/network_info.dart';
import 'package:bookia/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bookia/features/auth/data/repo/auth_repository_impl.dart';
import 'package:bookia/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:bookia/features/auth/presentation/screens/forget_password.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:bookia/features/book_details/presentation/screens/book_details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/welcome/screens/splash_screen.dart';
import 'package:bookia/features/welcome/screens/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  // 🔥 Routes Names
  static const String splash = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String mainApp = "/mainApp";
  static const String forgetPassword = "/forget-password";
  static const String otpScreen = "/otpScreen";
  static const String createNewPassword = "/create-new-password";
  static const String passwordChanged = "/password-changed";
  static const String bookDetails = "/book-details";

  // 🔥 Future routes (بدل null)
  static const String placeOrder = "/place-order";
  static const String search = "/search";
  static const String orderDetails = "/order-details";
  static const String congrats = "/congrats";
  static const String myOrders = "/my-orders";
  static const String editProfile = "/edit-profile";
  static const String resetPassword = "/reset-password";

  /// 🔥 Cubit Factory (عشان نمنع التكرار)
  static AuthCubit _buildAuthCubit() {
    final dio = DioClient();
    final remoteDS = AuthRemoteDataSourceImpl(dio);
    final networkInfo = NetworkInfoImpl();

    final repository = AuthRepositoryImpl(
      remoteDataSource: remoteDS,
      networkInfo: networkInfo,
    );

    return AuthCubit(
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      forgetPasswordUseCase: ForgetPasswordUseCase(repository),
    );
  }

  // 🔥 Router
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (_, _) => const SplashScreen(),
      ),

      GoRoute(
        path: welcome,
        builder: (_, _) => const WelcomeScreen(),
      ),

      GoRoute(
        path: login,
        builder: (_, _) => BlocProvider(
          create: (_) => _buildAuthCubit(),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: register,
        builder: (_, _) => BlocProvider(
          create: (_) => _buildAuthCubit(),
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: forgetPassword,
        builder: (_, _) => const ForgetPasswordScreen(),
      ),

      GoRoute(
        path: otpScreen,
        builder: (_, _) => const OtpVerificationScreen(),
      ),

      GoRoute(
        path: createNewPassword,
        builder: (_, _) => const CreateNewPasswordScreen(),
      ),

      GoRoute(
        path: passwordChanged,
        builder: (_, _) => const PasswordChangedScreen(),
      ),

      GoRoute(
        path: mainApp,
        builder: (_, _) => const MainAppScreen(),
      ),

      GoRoute(
        path: bookDetails,
        builder: (_, state) =>
            BookDetailsScreen(product: state.extra as dynamic),
      ),
    ],
  );
}