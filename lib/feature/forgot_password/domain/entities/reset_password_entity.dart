import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_entity.freezed.dart';

@freezed
abstract class ResetPasswordEntity with _$ResetPasswordEntity {
  const factory ResetPasswordEntity({
    required String email,
    required String newPassword,
  }) = _ResetPasswordEntity;
}
