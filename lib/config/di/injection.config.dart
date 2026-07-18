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
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart'
    as _i966;
import 'package:exam_app/feature/auth/domain/use_cases/sign_up_use_case.dart'
    as _i287;
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart'
    as _i196;
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart'
    as _i995;
import 'package:exam_app/feature/forget_password/api/client/forget_password_api_client.dart'
    as _i218;
import 'package:exam_app/feature/forget_password/api/data_source/forget_password_remote_data_source_impl.dart'
    as _i218;
import 'package:exam_app/feature/forget_password/data/data_sources/remote/forget_password_remote_data_source.dart'
    as _i1024;
import 'package:exam_app/feature/forget_password/data/repos/forget_password_repo_impl.dart'
    as _i270;
import 'package:exam_app/feature/forget_password/domain/repos/forget_password_repo.dart'
    as _i781;
import 'package:exam_app/feature/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i40;
import 'package:exam_app/feature/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i51;
import 'package:exam_app/feature/forget_password/domain/use_cases/verify_reset_code_use_case.dart'
    as _i913;
import 'package:exam_app/feature/forget_password/presentation/email_verification/view_model/email_verification_view_model.dart'
    as _i625;
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart'
    as _i194;
import 'package:exam_app/feature/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart'
    as _i444;
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
    gh.singleton<_i218.ForgetPasswordApiClient>(
      () => _i218.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1037.SecureStorageService>(
      () => _i1037.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i516.AuthRemoteDataSource>(
      () => _i939.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i355.AuthApiClient>(),
      ),
    );
    gh.lazySingleton<_i1024.ForgetPasswordRemoteDataSource>(
      () => _i218.ForgetPasswordRemoteDataSourceImpl(
        forgetPasswordApiClient: gh<_i218.ForgetPasswordApiClient>(),
      ),
    );
    gh.lazySingleton<_i820.AuthRepo>(
      () => _i623.AuthRepoImpl(
        authRemoteDataSource: gh<_i516.AuthRemoteDataSource>(),
        secureStorageService: gh<_i1037.SecureStorageService>(),
      ),
    );
    gh.lazySingleton<_i781.ForgetPasswordRepo>(
      () => _i270.ForgetPasswordRepoImpl(
        forgetPasswordRemoteDataSource:
            gh<_i1024.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i40.ForgetPasswordUseCase>(
      () => _i40.ForgetPasswordUseCase(gh<_i781.ForgetPasswordRepo>()),
    );
    gh.lazySingleton<_i51.ResetPasswordUseCase>(
      () => _i51.ResetPasswordUseCase(gh<_i781.ForgetPasswordRepo>()),
    );
    gh.lazySingleton<_i913.VerifyResetCodeUseCase>(
      () => _i913.VerifyResetCodeUseCase(gh<_i781.ForgetPasswordRepo>()),
    );
    gh.factory<_i625.EmailVerificationViewModel>(
      () => _i625.EmailVerificationViewModel(
        gh<_i913.VerifyResetCodeUseCase>(),
        gh<_i40.ForgetPasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i966.LoginUseCase>(
      () => _i966.LoginUseCase(gh<_i820.AuthRepo>()),
    );
    gh.factory<_i194.ForgetPasswordViewModel>(
      () => _i194.ForgetPasswordViewModel(gh<_i40.ForgetPasswordUseCase>()),
    );
    gh.factory<_i444.ResetPasswordViewModel>(
      () => _i444.ResetPasswordViewModel(gh<_i51.ResetPasswordUseCase>()),
    );
    gh.lazySingleton<_i287.SignUpUseCase>(
      () => _i287.SignUpUseCase(gh<_i820.AuthRepo>()),
    );
    gh.factory<_i196.LoginViewModel>(
      () => _i196.LoginViewModel(gh<_i966.LoginUseCase>()),
    );
    gh.factory<_i995.SignUpViewModel>(
      () => _i995.SignUpViewModel(gh<_i287.SignUpUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i316.AppModule {}
