import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    BaseState<ProfileEntity>? profileState,
    BaseState<ProfileEntity>? updateProfileState,
    BaseState<ChangePasswordEntity>? changePasswordState,
  }) = _ProfileState;

  factory ProfileState.initial() {
    return const ProfileState(
      profileState: BaseState<ProfileEntity>(),
      updateProfileState: BaseState<ProfileEntity>(),
      changePasswordState: BaseState<ChangePasswordEntity>(),
    );
  }
}
