import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
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
    ],
  );
}
