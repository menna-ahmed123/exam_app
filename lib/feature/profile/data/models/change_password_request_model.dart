import 'package:exam_app/feature/profile/domain/entities/change_password_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_model.g.dart';

@JsonSerializable()
class ChangePasswordRequestModel {
  final String oldPassword;
  final String password;
  final String rePassword;

  ChangePasswordRequestModel({
    required this.oldPassword,
    required this.password,
    required this.rePassword,
  });

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestModelToJson(this);

  factory ChangePasswordRequestModel.fromDomain(ChangePasswordParams params) {
    return ChangePasswordRequestModel(
      oldPassword: params.oldPassword,
      password: params.password,
      rePassword: params.rePassword,
    );
  }
}
