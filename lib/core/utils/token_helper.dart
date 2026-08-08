import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';

Future<void> saveToken(
  SecureStorageService secureStorageService,
  String token,
) {
  return secureStorageService.write(key: StorageKeys.accessToken, value: token);
}
