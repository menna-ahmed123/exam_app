import 'package:dio/dio.dart';
import 'package:exam_app/config/app_module/app_module.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  final appModule = AppModuleRegistry();
  getIt.registerLazySingleton<Dio>(appModule.dio);
  getIt.registerLazySingleton<FlutterSecureStorage>(appModule.secureStorage);
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(getIt<FlutterSecureStorage>()),
  );
}
