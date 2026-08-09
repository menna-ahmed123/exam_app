import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/app_shell.dart';
import 'package:exam_app/core/routing/go_router_refresh_stream.dart';

import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_state.dart';
import 'package:exam_app/feature/auth/presentation/login/cubit/login_cubit.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/cubit/sign_up_cubit.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/views/sign_up_view.dart';

import 'package:exam_app/feature/forgot_password/presentation/email_verification/cubit/email_verification_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/views/email_verification_view.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/views/forgot_password_view.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/views/reset_password_view.dart';

import 'package:exam_app/feature/home/presentation/views/home_view.dart';

import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/profile/presentation/views/profile_change_password_view.dart';
import 'package:exam_app/feature/profile/presentation/views/profile_edit_view.dart';
import 'package:exam_app/feature/profile/presentation/views/profile_view.dart';

import 'package:exam_app/feature/result/presentation/views/result_view.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRouter {
  AppRouter(this.authCubit);

  final AuthCubit authCubit;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: redirect,
    routes: routes,
  );

  String? redirect(BuildContext context, GoRouterState state) {
    final authStatus = authCubit.state.status;
    final location = state.matchedLocation;

    if (authStatus == AuthStatus.unknown) {
      return null;
    }

    final isLoggedIn = authStatus == AuthStatus.authenticated;

    final isAuthFlow = isAuthFlowLocation(location);

    if (!isLoggedIn && !isAuthFlow) {
      return AppRoutes.login;
    }

    if (isLoggedIn && isLoginOrSignUp(location)) {
      return AppRoutes.home;
    }

    return null;
  }

  bool isAuthFlowLocation(String location) {
    return location == AppRoutes.login ||
        location == AppRoutes.signUp ||
        location == AppRoutes.forgotPassword ||
        location == AppRoutes.emailVerification ||
        location == AppRoutes.resetPassword;
  }

  bool isLoginOrSignUp(String location) {
    return location == AppRoutes.login || location == AppRoutes.signUp;
  }

  List<RouteBase> get routes => [
    // =========================
    // Login
    // =========================
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.loginRoute,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginView(),
        );
      },
    ),

    // =========================
    // Sign Up
    // =========================
    GoRoute(
      path: AppRoutes.signUp,
      name: AppRoutes.signUpRoute,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<SignUpCubit>(),
          child: const SignUpView(),
        );
      },
    ),

    // =========================
    // Forgot Password
    // =========================
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: AppRoutes.forgotPasswordRoute,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordView(),
        );
      },
    ),

    // =========================
    // Email Verification
    // =========================
    GoRoute(
      path: AppRoutes.emailVerification,
      name: AppRoutes.emailVerificationRoute,
      builder: (context, state) {
        final email = state.extra as String? ?? '';

        return BlocProvider(
          create: (_) => getIt<EmailVerificationCubit>(),
          child: EmailVerificationView(email: email),
        );
      },
    ),

    // =========================
    // Reset Password
    // =========================
    GoRoute(
      path: AppRoutes.resetPassword,
      name: AppRoutes.resetPasswordRoute,
      builder: (context, state) {
        final email = state.extra as String? ?? '';

        return BlocProvider(
          create: (_) => getIt<ResetPasswordCubit>(),
          child: ResetPasswordView(email: email),
        );
      },
    ),

    // =====================================================
    // Authenticated App
    // =====================================================
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // =========================
        // Explore
        // =========================
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.homeRoute,
              builder: (context, state) {
                return const ExploreView();
              },
            ),
          ],
        ),

        // =========================
        // Result
        // =========================
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.result,
              name: AppRoutes.resultRoute,
              builder: (context, state) {
                return const ResultView();
              },
            ),
          ],
        ),

        // =========================
        // Profile
        // =========================
        StatefulShellBranch(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return BlocProvider(
                  create: (_) => getIt<ProfileViewModel>(),
                  child: child,
                );
              },
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profileRoute,
                  builder: (context, state) {
                    return const ProfileView();
                  },
                  routes: [
                    // =========================
                    // Edit Profile
                    // =========================
                    GoRoute(
                      path: 'edit',
                      name: AppRoutes.profileEditRoute,
                      builder: (context, state) {
                        return const ProfileEditView();
                      },
                    ),

                    // =========================
                    // Change Password
                    // =========================
                    GoRoute(
                      path: 'change-password',
                      name: AppRoutes.profileChangePasswordRoute,
                      builder: (context, state) {
                        return const ProfileChangePassword();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
