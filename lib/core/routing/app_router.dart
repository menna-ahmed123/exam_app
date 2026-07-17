import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/views/sign_up_view.dart';
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
        builder: (context,state) => BlocProvider(
          create: (context) => getIt<LoginViewModel>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
        GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignUpViewModel>(),
          child: const SignUpView(),
        ),
      ),
    ],
  );
  
}

   