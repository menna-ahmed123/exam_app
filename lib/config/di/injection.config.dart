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
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart'
    as _i565;
import 'package:exam_app/feature/auth/api/data_source/auth_remote_data_source_impl.dart'
    as _i954;
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i164;
import 'package:exam_app/feature/auth/data/repos/auth_repo_impl.dart' as _i655;
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart' as _i256;
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart'
    as _i966;
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart'
    as _i542;
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
    gh.singleton<_i565.AuthApiClient>(
      () => _i565.AuthApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1037.SecureStorageService>(
      () => _i1037.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i164.AuthRemoteDataSource>(
      () => _i954.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i565.AuthApiClient>(),
      ),
    );
    gh.lazySingleton<_i256.AuthRepo>(
      () => _i655.AuthRepoImpl(
        authRemoteDataSource: gh<_i164.AuthRemoteDataSource>(),
        secureStorageService: gh<_i1037.SecureStorageService>(),
      ),
    );
    gh.lazySingleton<_i966.LoginUseCase>(
      () => _i966.LoginUseCase(gh<_i256.AuthRepo>()),
    );
    
    gh.factory<_i542.LoginViewModel>(
      () => _i542.LoginViewModel(gh<_i966.LoginUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i316.AppModule {}
