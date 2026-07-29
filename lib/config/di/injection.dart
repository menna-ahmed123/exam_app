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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  _registerCore();
  _registerAuthData();
  _registerAuthPresentation();
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
