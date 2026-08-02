import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String role,
    required bool isVerified,
  }) = _UserEntity;
}
