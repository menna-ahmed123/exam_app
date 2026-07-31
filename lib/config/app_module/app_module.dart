import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
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
  return LogInterceptor(
    requestBody: true,
    responseBody: true,
  );
}

@module
abstract class AppModule {
  @lazySingleton
  Dio dio() {
    final client = Dio(createBaseOptions());
    if (kDebugMode) {
      client.interceptors.add(createDebugLogInterceptor());
    }
    return client;
  }

  @lazySingleton
  FlutterSecureStorage secureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}

class AppModuleRegistry extends AppModule {}
