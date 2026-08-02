import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_reset_code_entity.freezed.dart';

@freezed
abstract class VerifyResetCodeEntity with _$VerifyResetCodeEntity {
  const factory VerifyResetCodeEntity({
    required String resetCode,
  }) = _VerifyResetCodeEntity;
}
