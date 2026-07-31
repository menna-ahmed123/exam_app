import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._secureStorageService) : super(const AuthState());

  final SecureStorageService _secureStorageService;

  Future<void> checkAuthStatus() async {
    final token = await _secureStorageService.read(
      key: StorageKeys.accessToken,
    );
    final hasToken = token != null && token.isNotEmpty;
    emit(
      AuthState(
        status: hasToken
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      ),
    );
  }

  void setAuthenticated() {
    emit(const AuthState(status: AuthStatus.authenticated));
  }

  Future<void> logout() async {
    await _secureStorageService.delete(key: StorageKeys.accessToken);
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
