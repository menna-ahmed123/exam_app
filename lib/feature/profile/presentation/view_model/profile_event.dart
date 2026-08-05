import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';

sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParams params;

  UpdateProfileEvent({required this.params});
}
