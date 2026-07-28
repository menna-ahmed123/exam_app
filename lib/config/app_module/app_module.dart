import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

BaseOptions _createBaseOptions() {
  return BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    headers: {'Content-Type': 'application/json'},
  );
}

LogInterceptor _createDebugLogInterceptor() {
  return LogInterceptor(
    requestBody: true,
    responseBody: true,
  );
}

@module
abstract class AppModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(_createBaseOptions());
    if (kDebugMode) {
      dio.interceptors.add(_createDebugLogInterceptor());
    }
    return dio;
  }

  @lazySingleton
  FlutterSecureStorage secureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}
