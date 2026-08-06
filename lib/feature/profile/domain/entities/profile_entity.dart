import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String role,
    required bool isVerified,
    required String createdAt,
  }) = _ProfileEntity;
}
