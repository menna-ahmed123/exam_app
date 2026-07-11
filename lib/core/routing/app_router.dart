import 'package:exam_app/core/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view/reset_password_view.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view/verify_reset_code_view.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/reset_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/verify_reset_code_cubit.dart';
import 'package:exam_app/features/auth/login/presentation/view/login_view.dart';
import 'package:exam_app/features/auth/sign_up/presentation/view/sign_up_view.dart';
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
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        name: 'forgetPassword',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ForgetPasswordCubit>(),
          child: const ForgetPasswordView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: 'emailVerification',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => getIt<VerifyResetCodeCubit>()..init(email),
            child: VerifyResetCodeView(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>()..init(email),
            child: ResetPasswordView(email: email),
          );
        },
      ),
    ],
  );
}
