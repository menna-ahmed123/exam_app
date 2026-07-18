import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_view_model.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/views/email_verification_view.dart';
import 'package:exam_app/feature/auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:exam_app/feature/auth/presentation/forget_password/views/forget_password_view.dart';
import 'package:exam_app/feature/auth/presentation/reset_password/view_model/reset_password_view_model.dart';
import 'package:exam_app/feature/auth/presentation/reset_password/views/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.forgetPassword,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        builder: (context, state) => const Placeholder(),
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
