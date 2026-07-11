import 'package:dio/dio.dart';
import 'package:exam_app/core/api/dio_client.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/features/auth/forget_password/api/client/forget_password_api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioClient.create();

  @lazySingleton
  FlutterSecureStorage get secureStorage => SecureStorageServiceImpl.create();

  @lazySingleton
  ForgetPasswordApiClient forgetPasswordApiClient(Dio dio) =>
      ForgetPasswordApiClient(dio);
}
