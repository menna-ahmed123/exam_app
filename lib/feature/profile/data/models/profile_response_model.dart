import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';

import 'profile_model.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'user')
  final ProfileModel user;

  ProfileResponseModel({required this.message, required this.user});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);

  ProfileEntity toDomain() {
    return user.toDomain();
  }
}
