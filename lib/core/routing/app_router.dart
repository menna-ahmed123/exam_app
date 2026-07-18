import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/views/sign_up_view.dart';
import 'package:exam_app/feature/forget_password/presentation/email_verification/view_model/email_verification_view_model.dart';
import 'package:exam_app/feature/forget_password/presentation/email_verification/views/email_verification_view.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/views/forget_password_view.dart';
import 'package:exam_app/feature/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:exam_app/feature/forget_password/presentation/reset_password/views/reset_password_view.dart';
import 'package:exam_app/feature/home/presentation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LoginViewModel>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SignUpViewModel>(),
          child: const SignUpView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        name: 'forgetPassword',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ForgetPasswordViewModel>(),
          child: const ForgetPasswordView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: 'emailVerification',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => getIt<EmailVerificationViewModel>(),
            child: EmailVerificationView(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => getIt<ResetPasswordViewModel>(),
            child: ResetPasswordView(email: email),
          );
        },
      ),
    ],
  );
}
