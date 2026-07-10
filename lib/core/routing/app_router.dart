import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/route_placeholder.dart';
import 'package:exam_app/feature/auth/presentation/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/views/sign_up_view.dart';
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
        builder: (context, state) => const SignUpView()
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        name: 'forgetPassword',
        builder: (context, state) => const RoutePlaceholder(
          title: AppStrings.forgetPasswordTitle,
        ),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: 'emailVerification',
        builder: (context, state) => const RoutePlaceholder(
          title: AppStrings.emailVerification,
        ),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) => const RoutePlaceholder(
          title: AppStrings.resetPassword,
        ),
      ),
    ],
  );
}
