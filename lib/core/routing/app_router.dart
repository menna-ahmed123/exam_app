import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/go_router_refresh_stream.dart';
import 'package:exam_app/core/routing/route_placeholder.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_state.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/views/sign_up_view.dart';
import 'package:exam_app/feature/home/presentation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final AuthCubit _authCubit = getIt<AuthCubit>();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final authStatus = _authCubit.state.status;
      final location = state.matchedLocation;
      final isAuthFlow = location == AppRoutes.login ||
          location == AppRoutes.signUp ||
          location == AppRoutes.forgetPassword ||
          location == AppRoutes.emailVerification ||
          location == AppRoutes.resetPassword;
      if (authStatus == AuthStatus.unknown) {
        return null;
      }
      final isLoggedIn = authStatus == AuthStatus.authenticated;
      if (!isLoggedIn && !isAuthFlow) {
        return AppRoutes.login;
      }
      if (isLoggedIn &&
          (location == AppRoutes.login || location == AppRoutes.signUp)) {
        return AppRoutes.home;
      }
      return null;
    },
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
        builder: (context, state) =>
            const RoutePlaceholder(title: 'Forget password'),
      ),
      GoRoute(
        path: AppRoutes.emailVerification,
        name: 'emailVerification',
        builder: (context, state) =>
            const RoutePlaceholder(title: 'Email verification'),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) =>
            const RoutePlaceholder(title: 'Reset password'),
      ),
    ],
  );
}
