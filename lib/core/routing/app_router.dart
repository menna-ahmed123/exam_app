import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
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
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          name: 'signUp',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<SignUpCubit>(),
            child: const SignUpView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          name: 'forgotPassword',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.emailVerification,
          name: 'emailVerification',
          builder: (context, state) {
            final email = state.extra as String? ?? '';
            return BlocProvider(
              create: (_) => getIt<EmailVerificationCubit>(),
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
              create: (_) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordView(email: email),
            );
          },
        ),
         GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ProfileViewModel>(),
        child: const ProfileView(),
      ),
    ),
   GoRoute(
      path: AppRoutes.profileEdit,
      name: 'profileEdit',
      builder: (context, state) {
        final viewModel = state.extra as ProfileViewModel;

        return BlocProvider.value(
          value: viewModel,
          child: const ProfileEditView(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.profileChangePassword,
      name: 'profileChangePassword',
      builder: (context, state) {
        final viewModel = state.extra as ProfileViewModel;

        return BlocProvider.value(
          value: viewModel,
          child: const ProfileChangePassword(),
        );
      },
    ),
      ];
}
