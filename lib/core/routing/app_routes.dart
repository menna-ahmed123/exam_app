class AppRoutes {
  AppRoutes._();

  // ===== Auth Paths =====

  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String emailVerification = '/verification';
  static const String resetPassword = '/reset-password';

  // ===== Main Paths =====

  static const String home = '/home';
  static const String result = '/result';
  static const String profile = '/profile';

  // ===== Profile Paths =====

  static const String profileEdit = '/profile/edit';
  static const String profileChangePassword = '/profile/change-password';

  // ===== Route Names =====

  static const String loginRoute = 'login';
  static const String signUpRoute = 'signUp';
  static const String forgotPasswordRoute = 'forgotPassword';
  static const String emailVerificationRoute = 'emailVerification';
  static const String resetPasswordRoute = 'resetPassword';

  static const String homeRoute = 'home';
  static const String resultRoute = 'result';
  static const String profileRoute = 'profile';

  static const String profileEditRoute = 'profileEdit';
  static const String profileChangePasswordRoute = 'profileChangePassword';
}
