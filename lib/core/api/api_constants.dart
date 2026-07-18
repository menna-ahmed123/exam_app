class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String forgetPasswordEndPoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndPoint = 'auth/verifyResetCode';
  static const String resetPasswordEndPoint = 'auth/resetPassword';
}
