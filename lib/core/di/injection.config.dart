// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:exam_app/core/di/app_module.dart' as _i917;
import 'package:exam_app/core/storage/secure_storage_service.dart' as _i1037;
import 'package:exam_app/features/auth/forget_password/api/client/forget_password_api_client.dart'
    as _i536;
import 'package:exam_app/features/auth/forget_password/api/datasource/remote/forget_password_api_datasource.dart'
    as _i368;
import 'package:exam_app/features/auth/forget_password/data/repo/forget_password_repo_impl.dart'
    as _i932;
import 'package:exam_app/features/auth/forget_password/domain/repo/forget_password_repo.dart'
    as _i991;
import 'package:exam_app/features/auth/forget_password/domain/usecases/forgot_password.dart'
    as _i410;
import 'package:exam_app/features/auth/forget_password/domain/usecases/reset_password.dart'
    as _i19;
import 'package:exam_app/features/auth/forget_password/domain/usecases/verify_reset_code.dart'
    as _i92;
import 'package:exam_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart'
    as _i418;
import 'package:exam_app/features/auth/forget_password/presentation/view_model/reset_password_cubit.dart'
    as _i148;
import 'package:exam_app/features/auth/forget_password/presentation/view_model/verify_reset_code_cubit.dart'
    as _i425;
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
    gh.lazySingleton<_i536.ForgetPasswordApiClient>(
      () => appModule.forgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1037.SecureStorageService>(
      () => _i1037.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i368.ForgetPasswordApiDatasource>(
      () => _i368.ForgetPasswordApiDatasourceImpl(
        gh<_i536.ForgetPasswordApiClient>(),
      ),
    );
    gh.lazySingleton<_i991.ForgetPasswordRepo>(
      () =>
          _i932.ForgetPasswordRepoImpl(gh<_i368.ForgetPasswordApiDatasource>()),
    );
    gh.lazySingleton<_i410.ForgotPasswordUseCase>(
      () => _i410.ForgotPasswordUseCase(gh<_i991.ForgetPasswordRepo>()),
    );
    gh.lazySingleton<_i19.ResetPasswordUseCase>(
      () => _i19.ResetPasswordUseCase(gh<_i991.ForgetPasswordRepo>()),
    );
    gh.lazySingleton<_i92.VerifyResetCodeUseCase>(
      () => _i92.VerifyResetCodeUseCase(gh<_i991.ForgetPasswordRepo>()),
    );
    gh.factory<_i148.ResetPasswordCubit>(
      () => _i148.ResetPasswordCubit(gh<_i19.ResetPasswordUseCase>()),
    );
    gh.factory<_i425.VerifyResetCodeCubit>(
      () => _i425.VerifyResetCodeCubit(
        gh<_i92.VerifyResetCodeUseCase>(),
        gh<_i410.ForgotPasswordUseCase>(),
      ),
    );
    gh.factory<_i418.ForgetPasswordCubit>(
      () => _i418.ForgetPasswordCubit(gh<_i410.ForgotPasswordUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i917.AppModule {}
