import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_entity.freezed.dart';

@freezed
abstract class ForgotPasswordEntity with _$ForgotPasswordEntity {
  const factory ForgotPasswordEntity({
    required String email,
  }) = _ForgotPasswordEntity;
}
