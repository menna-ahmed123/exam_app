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

final getIt = GetIt.instance;

void configureDependencies() {
  _registerCore();
  _registerAuthData();
  _registerAuthPresentation();
  _registerForgetPasswordData();
  _registerForgetPasswordPresentation();
}

void _registerCore() {
  final appModule = AppModuleRegistry();
  getIt.registerLazySingleton<Dio>(appModule.dio);
  getIt.registerLazySingleton<FlutterSecureStorage>(appModule.secureStorage);
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(getIt<FlutterSecureStorage>()),
  );
}

void _registerAuthData() {
  getIt.registerSingleton<AuthApiClient>(AuthApiClient(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(authApiClient: getIt<AuthApiClient>()),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      secureStorageService: getIt<SecureStorageService>(),
    ),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepo>()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepo>()),
  );
}

void _registerAuthPresentation() {
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<SecureStorageService>()),
  );
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(getIt<LoginUseCase>()),
  );
  getIt.registerFactory<SignUpViewModel>(
    () => SignUpViewModel(getIt<SignUpUseCase>()),
  );
}

void _registerForgetPasswordData() {
  getIt.registerSingleton<ForgetPasswordApiClient>(
    ForgetPasswordApiClient(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ForgetPasswordRemoteDataSource>(
    () => ForgetPasswordRemoteDataSourceImpl(
      forgetPasswordApiClient: getIt<ForgetPasswordApiClient>(),
    ),
  );
  getIt.registerLazySingleton<ForgetPasswordRepo>(
    () => ForgetPasswordRepoImpl(
      forgetPasswordRemoteDataSource: getIt<ForgetPasswordRemoteDataSource>(),
    ),
  );
  _registerForgetPasswordUseCases();
}

void _registerForgetPasswordUseCases() {
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(getIt<ForgetPasswordRepo>()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<ForgetPasswordRepo>()),
  );
  getIt.registerLazySingleton<VerifyResetCodeUseCase>(
    () => VerifyResetCodeUseCase(getIt<ForgetPasswordRepo>()),
  );
}

void _registerForgetPasswordPresentation() {
  getIt.registerFactory<ForgetPasswordViewModel>(
    () => ForgetPasswordViewModel(getIt<ForgetPasswordUseCase>()),
  );
  getIt.registerFactory<EmailVerificationViewModel>(
    () => EmailVerificationViewModel(
      getIt<VerifyResetCodeUseCase>(),
      getIt<ForgetPasswordUseCase>(),
    ),
  );
  getIt.registerFactory<ResetPasswordViewModel>(
    () => ResetPasswordViewModel(getIt<ResetPasswordUseCase>()),
  );
}
