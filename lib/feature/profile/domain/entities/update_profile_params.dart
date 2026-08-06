

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_params.freezed.dart';

@freezed
abstract class UpdateProfileParams with _$UpdateProfileParams {
  const factory UpdateProfileParams({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) = _UpdateProfileParams;
}
