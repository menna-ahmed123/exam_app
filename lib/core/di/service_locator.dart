import 'package:dio/dio.dart';
import 'package:exam_app/core/api/dio_client.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/di/forget_password_di.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(DioClient.create);

  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(SecureStorageServiceImpl.create()),
  );

  initForgetPasswordDependencies();
}
