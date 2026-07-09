import 'package:exam_app/core/constants/ui_strings.dart';
import 'package:exam_app/core/di/service_locator.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/route_placeholder.dart';
import 'package:exam_app/features/auth/forget_password/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/forget_password/pages/forget_password_page.dart';
import 'package:exam_app/features/auth/forget_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/reset_password/pages/reset_password_page.dart';
import 'package:exam_app/features/auth/forget_password/presentation/verify_code/cubit/verify_reset_code_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/verify_code/pages/verify_reset_code_page.dart';
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
        builder: (context, state) => const RoutePlaceholder(
          title: AppStrings.login,
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        builder: (context, state) => const RoutePlaceholder(
          title: AppStrings.signUpTitle,
        ),
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        name: 'forgetPassword',
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ForgetPasswordCubit>(),
          child: const ForgetPasswordPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: 'emailVerification',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => sl<VerifyResetCodeCubit>()..init(email),
            child: VerifyResetCodePage(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => sl<ResetPasswordCubit>()..init(email),
            child: ResetPasswordPage(email: email),
          );
        },
      ),
    ],
  );
}
