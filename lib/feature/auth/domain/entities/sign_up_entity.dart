import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_entity.freezed.dart';

@freezed
abstract class SignUpEntity with _$SignUpEntity {
  const factory SignUpEntity({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) = _SignUpEntity;
}
