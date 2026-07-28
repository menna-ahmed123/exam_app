import 'package:dio/dio.dart';
import 'package:exam_app/config/app_module/app_module.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart';
import 'package:exam_app/feature/auth/api/data_source/auth_remote_data_source_impl.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/repos/auth_repo_impl.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:exam_app/feature/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/forget_password/api/client/forget_password_api_client.dart';
import 'package:exam_app/feature/forget_password/api/data_source/forget_password_remote_data_source_impl.dart';
import 'package:exam_app/feature/forget_password/data/data_sources/remote/forget_password_remote_data_source.dart';
import 'package:exam_app/feature/forget_password/data/repos/forget_password_repo_impl.dart';
import 'package:exam_app/feature/forget_password/domain/repos/forget_password_repo.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:exam_app/feature/forget_password/presentation/email_verification/view_model/email_verification_view_model.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:exam_app/feature/forget_password/presentation/reset_password/view_model/reset_password_view_model.dart';
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
    registerSingleton<AuthApiClient>(AuthApiClient(get<Dio>()));
    registerSingleton<ForgetPasswordApiClient>(
      ForgetPasswordApiClient(get<Dio>()),
    );
    registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(get<FlutterSecureStorage>()),
    );
    registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(authApiClient: get<AuthApiClient>()),
    );
    registerLazySingleton<AuthCubit>(
      () => AuthCubit(get<SecureStorageService>()),
    );
    registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSourceImpl(
        forgetPasswordApiClient: get<ForgetPasswordApiClient>(),
      ),
    );
    registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        authRemoteDataSource: get<AuthRemoteDataSource>(),
        secureStorageService: get<SecureStorageService>(),
      ),
    );
    registerLazySingleton<ForgetPasswordRepo>(
      () => ForgetPasswordRepoImpl(
        forgetPasswordRemoteDataSource: get<ForgetPasswordRemoteDataSource>(),
      ),
    );
    registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(get<ForgetPasswordRepo>()),
    );
    registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(get<ForgetPasswordRepo>()),
    );
    registerLazySingleton<VerifyResetCodeUseCase>(
      () => VerifyResetCodeUseCase(get<ForgetPasswordRepo>()),
    );
    registerFactory<EmailVerificationViewModel>(
      () => EmailVerificationViewModel(
        get<VerifyResetCodeUseCase>(),
        get<ForgetPasswordUseCase>(),
      ),
    );
    registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(get<AuthRepo>()),
    );
    registerFactory<ForgetPasswordViewModel>(
      () => ForgetPasswordViewModel(get<ForgetPasswordUseCase>()),
    );
    registerFactory<ResetPasswordViewModel>(
      () => ResetPasswordViewModel(get<ResetPasswordUseCase>()),
    );
    registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(get<AuthRepo>()),
    );
    registerFactory<LoginViewModel>(
      () => LoginViewModel(get<LoginUseCase>()),
    );
    registerFactory<SignUpViewModel>(
      () => SignUpViewModel(get<SignUpUseCase>()),
    );

    return this;
  }
}

class AppModuleImpl extends AppModule {}
