class AppRoutes {
  AppRoutes._();

  // =========================
  // Auth
  // =========================
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String emailVerification = '/email-verification';
  static const String resetPassword = '/reset-password';

  static const String loginRoute = 'login';
  static const String signUpRoute = 'signUp';
  static const String forgotPasswordRoute = 'forgotPassword';
  static const String emailVerificationRoute = 'emailVerification';
  static const String resetPasswordRoute = 'resetPassword';

  // =========================
  // Main
  // =========================
  static const String home = '/home';
  static const String result = '/result';
  static const String profile = '/profile';

  static const String homeRoute = 'home';
  static const String resultRoute = 'result';
  static const String profileRoute = 'profile';

  // =========================
  // Profile
  // =========================
  static const String profileEdit = 'profileEdit';
  static const String profileChangePassword = 'profileChangePassword';

  // =========================
  // Subject
  // =========================
  static const String subjectDetails = 'subject-details';
  static const String subjectDetailsRoute = 'subjectDetails';
}
