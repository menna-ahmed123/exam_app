import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/core/api/auth_interceptor.dart';
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart';
import 'package:exam_app/feature/forgot_password/api/client/forgot_password_api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

BaseOptions createBaseOptions() {
  return BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    headers: {'Content-Type': 'application/json'},
  );
}

LogInterceptor createDebugLogInterceptor() {
  return LogInterceptor(requestBody: true, responseBody: true);
}

@module
abstract class AppModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final client = Dio(createBaseOptions());

    client.interceptors.add(authInterceptor);

    if (kDebugMode) {
      client.interceptors.add(createDebugLogInterceptor());
    }

    return client;
  }

  @lazySingleton
  AuthApiClient authApiClient(Dio dio) => AuthApiClient(dio);

  @lazySingleton
  ForgotPasswordApiClient forgotPasswordApiClient(Dio dio) =>
      ForgotPasswordApiClient(dio);

  @lazySingleton
  FlutterSecureStorage secureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}
