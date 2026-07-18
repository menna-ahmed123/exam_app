import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'newPassword')
  final String newPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);

  factory ResetPasswordRequestModel.fromDomain(ResetPasswordEntity entity) {
    return ResetPasswordRequestModel(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }
}
