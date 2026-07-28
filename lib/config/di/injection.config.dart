// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:exam_app/config/app_module/app_module.dart' as _i316;
import 'package:exam_app/core/storage/secure_storage_service.dart' as _i1037;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i361.Dio>(() => appModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => appModule.secureStorage(),
    );
    gh.lazySingleton<_i1037.SecureStorageService>(
      () => _i1037.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    return this;
  }
}

class _$AppModule extends _i316.AppModule {}
