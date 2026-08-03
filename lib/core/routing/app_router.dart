import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/routing/go_router_refresh_stream.dart';
import 'package:exam_app/core/routing/invalid_extra_redirect.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_state.dart';
import 'package:exam_app/feature/auth/presentation/login/cubit/login_cubit.dart';
import 'package:exam_app/feature/auth/presentation/login/views/login_view.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/cubit/sign_up_cubit.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/views/sign_up_view.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_score_args.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:exam_app/feature/exam/presentation/answers/views/exam_answers_view.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_cubit.dart';
import 'package:exam_app/feature/exam/presentation/explore/views/explore_view.dart';
import 'package:exam_app/feature/exam/presentation/instructions/views/exam_instructions_view.dart';
import 'package:exam_app/feature/exam/presentation/score/views/exam_score_view.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_cubit.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/views/subject_exams_view.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_cubit.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/views/taking_exam_view.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/cubit/email_verification_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/views/email_verification_view.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/views/forgot_password_view.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/views/reset_password_view.dart';
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
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<ExploreCubit>(),
            child: const ExploreView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.subjectExams,
          name: 'subjectExams',
          builder: (context, state) {
            final subject = state.extra as SubjectEntity?;
            if (subject == null) {
              return const InvalidExtraRedirect();
            }
            return BlocProvider(
              create: (_) => getIt<SubjectExamsCubit>(),
              child: SubjectExamsView(subject: subject),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.examInstructions,
          name: 'examInstructions',
          builder: (context, state) {
            final args = state.extra as ExamSessionArgs?;
            if (args == null) {
              return const InvalidExtraRedirect();
            }
            return ExamInstructionsView(args: args);
          },
        ),
        GoRoute(
          path: AppRoutes.takingExam,
          name: 'takingExam',
          builder: (context, state) {
            final args = state.extra as ExamSessionArgs?;
            if (args == null) {
              return const InvalidExtraRedirect();
            }
            return BlocProvider(
              create: (_) => getIt<TakingExamCubit>(),
              child: TakingExamView(args: args),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.examScore,
          name: 'examScore',
          builder: (context, state) {
            final args = state.extra as ExamScoreArgs?;
            if (args == null) {
              return const InvalidExtraRedirect();
            }
            return ExamScoreView(args: args);
          },
        ),
        GoRoute(
          path: AppRoutes.examAnswers,
          name: 'examAnswers',
          builder: (context, state) {
            final history = state.extra as ExamHistoryEntity?;
            if (history == null) {
              return const InvalidExtraRedirect();
            }
            return ExamAnswersView(history: history);
          },
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
      ];
}
