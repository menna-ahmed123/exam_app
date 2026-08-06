import 'package:freezed_annotation/freezed_annotation.dart';
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
}
