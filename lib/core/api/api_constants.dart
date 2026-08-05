class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String loginEndpoint = 'auth/signin';
  static const String signUpEndpoint = 'auth/signup';
  static const String forgotPasswordEndpoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndpoint = 'auth/verifyResetCode';
  static const String resetPasswordEndpoint = 'auth/resetPassword';
  static const String profileDataEndpoint = 'auth/profileData';
  static const String updateProfileEndpoint = 'auth/editProfile';
 
}
