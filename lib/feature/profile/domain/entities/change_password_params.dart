import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_params.freezed.dart';

@freezed
abstract class ChangePasswordParams with _$ChangePasswordParams {
  const factory ChangePasswordParams({
    required String oldPassword,
    required String password,
    required String rePassword,
  }) = _ChangePasswordParams;
}
