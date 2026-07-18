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
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart' as _i355;
import 'package:exam_app/feature/auth/api/data_source/auth_remote_data_source_impl.dart'
    as _i939;
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i516;
import 'package:exam_app/feature/auth/data/repos/auth_repo_impl.dart' as _i623;
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart' as _i820;
import 'package:exam_app/feature/auth/domain/use_cases/forget_password_use_case.dart'
    as _i844;
import 'package:exam_app/feature/auth/domain/use_cases/reset_password_use_case.dart'
    as _i973;
import 'package:exam_app/feature/auth/domain/use_cases/verify_reset_code_use_case.dart'
    as _i441;
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_view_model.dart'
    as _i473;
import 'package:exam_app/feature/auth/presentation/forget_password/view_model/forget_password_view_model.dart'
    as _i512;
import 'package:exam_app/feature/auth/presentation/reset_password/view_model/reset_password_view_model.dart'
    as _i1025;
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
    gh.singleton<_i355.AuthApiClient>(
      () => _i355.AuthApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1037.SecureStorageService>(
      () => _i1037.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i516.AuthRemoteDataSource>(
      () => _i939.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i355.AuthApiClient>(),
      ),
    );
    gh.lazySingleton<_i820.AuthRepo>(
      () => _i623.AuthRepoImpl(
        authRemoteDataSource: gh<_i516.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i844.ForgetPasswordUseCase>(
      () => _i844.ForgetPasswordUseCase(gh<_i820.AuthRepo>()),
    );
    gh.lazySingleton<_i973.ResetPasswordUseCase>(
      () => _i973.ResetPasswordUseCase(gh<_i820.AuthRepo>()),
    );
    gh.lazySingleton<_i441.VerifyResetCodeUseCase>(
      () => _i441.VerifyResetCodeUseCase(gh<_i820.AuthRepo>()),
    );
    gh.factory<_i1025.ResetPasswordViewModel>(
      () => _i1025.ResetPasswordViewModel(gh<_i973.ResetPasswordUseCase>()),
    );
    gh.factory<_i473.EmailVerificationViewModel>(
      () => _i473.EmailVerificationViewModel(
        gh<_i441.VerifyResetCodeUseCase>(),
        gh<_i844.ForgetPasswordUseCase>(),
      ),
    );
    gh.factory<_i512.ForgetPasswordViewModel>(
      () => _i512.ForgetPasswordViewModel(gh<_i844.ForgetPasswordUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i316.AppModule {}
