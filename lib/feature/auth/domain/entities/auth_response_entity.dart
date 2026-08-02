import 'package:exam_app/feature/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_entity.freezed.dart';

@freezed
abstract class AuthResponseEntity with _$AuthResponseEntity {
  const factory AuthResponseEntity({
    required String message,
    required String token,
    required UserEntity user,
  }) = _AuthResponseEntity;
}
