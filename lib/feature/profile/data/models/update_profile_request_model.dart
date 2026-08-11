import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request_model.g.dart';

@JsonSerializable()
class UpdateProfileRequestModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  UpdateProfileRequestModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestModelToJson(this);

  factory UpdateProfileRequestModel.fromDomain(UpdateProfileParams params) {
    return UpdateProfileRequestModel(
      username: params.username,
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phone,
    );
  }
}
