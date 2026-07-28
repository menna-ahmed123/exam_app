import 'package:dio/dio.dart';
import 'package:exam_app/config/app_module/app_module.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

extension GetItInjectableX on GetIt {
  GetIt init({
    String? environment,
    EnvironmentFilter? environmentFilter,
  }) {
    final appModule = AppModuleImpl();
    registerLazySingleton<Dio>(appModule.dio);
    registerLazySingleton<FlutterSecureStorage>(appModule.secureStorage);
    registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(get<FlutterSecureStorage>()),
    );
    return this;
  }
}

class AppModuleImpl extends AppModule {}
