import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/route_placeholder.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const RoutePlaceholder(title: 'Home'),
      ),
    ],
  );
}
