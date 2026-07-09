import 'package:exam_app/core/di/service_locator.dart';
import 'package:exam_app/features/auth/forget_password/api/forget_password_api_service.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_remote_data_source.dart';
import 'package:exam_app/features/auth/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/forgot_password.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/reset_password.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/verify_reset_code.dart';
import 'package:exam_app/features/auth/forget_password/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/verify_code/cubit/verify_reset_code_cubit.dart';

void initForgetPasswordDependencies() {
  sl.registerLazySingleton<ForgetPasswordApiService>(
    () => ForgetPasswordApiService(sl()),
  );

  sl.registerLazySingleton<ForgetPasswordRemoteDataSource>(
    () => ForgetPasswordRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ForgetPasswordRepository>(
    () => ForgetPasswordRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyResetCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => VerifyResetCodeCubit(sl(), sl()));
  sl.registerFactory(() => ResetPasswordCubit(sl()));
}
