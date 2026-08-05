import 'package:dio/dio.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  AuthInterceptor(this._secureStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorageService.read(
      key: StorageKeys.accessToken,
    );

    if (token != null && token.isNotEmpty) {
      options.headers['token'] = token;
    }

    return handler.next(options);
  }
}
